import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../common/duration_provider.dart';
import '../common/widgets/blur_background_viewer.dart';
import '../common/widgets/transitions/fade_in_page_transition.dart';
import '../common/widgets/transitions/slide_bottom_page_transition.dart';

@lazySingleton
class AppNavigator {
  BuildContext? _context;

  BuildContext get context => _context!;

  void setContext(BuildContext context) => _context = context;

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState>? nestedNavigatorKey;

  BuildContext get currentContext => nestedNavigatorKey?.currentContext ?? navigatorKey.currentContext!;

  BuildContext get rootNavigatorContext => navigatorKey.currentContext!;

  CupertinoPageRoute<R> _builderCupertinoPageRoute<R>(Widget child) => CupertinoPageRoute<R>(builder: (context) => child);

  Future<R?> push<R>(Widget child, {bool useRoot = false}) async {
    return _navigator(_context, useRoot: useRoot).push(_builderCupertinoPageRoute<R>(child));
  }

  Future<R?> pushNamed<R>(String routeName, {R? arguments, bool useRoot = false}) async {
    return _navigator(_context, useRoot: useRoot).pushNamed(routeName, arguments: arguments);
  }

  Future<R?> pushReplacement<R>(Widget child, {bool useRoot = false}) async {
    return _navigator(_context, useRoot: useRoot).pushReplacement(_builderCupertinoPageRoute<R>(child));
  }

  Future<R?> pushNamedAndRemoveUntil<R>(String routeName, {R? arguments, bool useRoot = false}) async {
    return _navigator(_context, useRoot: useRoot).pushNamedAndRemoveUntil(routeName, (route) => false, arguments: arguments);
  }

  Future<R?> pushAndRemoveUntilRoot<R>(Widget child, {bool useRoot = false}) async {
    return _navigator(_context, useRoot: useRoot).pushAndRemoveUntil(_builderCupertinoPageRoute<R>(child), (route) => false);
  }

  void close() => closeWithResult(null);

  void closeWithResult<T>(T result) => _navigator(_context).canPop() ? _navigator(_context).pop(result) : result;

  void popUntilRoot() => _navigator(_context).popUntil((route) => false);

  void popUntilPageWithName(String title) => _navigator(_context).popUntil(ModalRoute.withName(title));
}

NavigatorState _navigator(BuildContext? context, {bool useRoot = false}) {
  assert(!(useRoot && (context != null)), "only (useRoot = true) or (context != null) can be specified, not both");
  final rootState = AppNavigator().navigatorKey.currentState;
  if (useRoot) return rootState!;

  return context != null ? Navigator.of(context) : (AppNavigator.nestedNavigatorKey?.currentState ?? rootState!);
}

RoutePageBuilder _pageBuilder(Widget page) => (context, animation, secondaryAnimation) => page;

Route<T> noTransitionRoute<T>(Widget page, {int? durationMillis, String? pageName, bool opaque = true}) => PageRouteBuilder<T>(
    opaque: opaque, transitionDuration: Duration.zero, settings: RouteSettings(name: pageName ?? page.runtimeType.toString()), pageBuilder: _pageBuilder(page));

Route<T> materialRoute<T>(Widget page, {bool fullScreenDialog = false, String? pageName}) =>
    MaterialPageRoute(builder: (context) => page, settings: RouteSettings(name: pageName ?? page.runtimeType.toString()), fullscreenDialog: fullScreenDialog);

Route<T> fadeInRoute<T>(
  Widget page, {
  int? durationMillis,
  String? pageName,
  bool opaque = true,
  bool fadeOut = true,
  bool fullScreenDialog = false,
}) =>
    PageRouteBuilder<T>(
      opaque: opaque,
      transitionDuration: Duration(milliseconds: durationMillis ?? Durations.medium),
      settings: RouteSettings(name: pageName ?? page.runtimeType.toString()),
      pageBuilder: _pageBuilder(page),
      transitionsBuilder: fadeInPageTransition(fadeOut: fadeOut),
      fullscreenDialog: fullScreenDialog,
    );

Route<T> displayModalRoute<T>(Widget page, {int? durationMillis, bool dismissible = true, String? pageName, Color? bgColor}) =>
    fadeInRoute(BlurBackgroundViewer(page: page, isDismissible: dismissible, bgColor: bgColor),
        durationMillis: durationMillis, opaque: false, fullScreenDialog: true);

Route<T> slideBottomRoute<T>(
  Widget page, {
  int? durationMillis,
  bool fullScreenDialog = false,
  String? pageName,
  bool opaque = true,
}) =>
    _transitionRoute(page,
        durationMillis: durationMillis,
        fullScreenDialog: fullScreenDialog,
        pageName: pageName,
        opaque: opaque,
        transitionsBuilder: slideBottomPageTransition());

Route<T> _transitionRoute<T>(Widget page,
        {int? durationMillis, bool fullScreenDialog = false, String? pageName, bool opaque = true, required RouteTransitionsBuilder transitionsBuilder}) =>
    PageRouteBuilder<T>(
      opaque: opaque,
      transitionDuration: Duration(milliseconds: durationMillis ?? Durations.medium),
      fullscreenDialog: fullScreenDialog,
      settings: RouteSettings(name: pageName ?? page.runtimeType.toString()),
      pageBuilder: _pageBuilder(page),
      transitionsBuilder: transitionsBuilder,
    );
