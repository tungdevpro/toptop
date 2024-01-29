import 'package:core/service/app_loading.dart';
import 'package:core/service/app_navigator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:environment/environment.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_lib/permission_lib.dart';
import 'package:presentation/common/themes/theme_manager.dart';
import 'package:presentation/import.dart';

typedef AsyncCallbackFunc = Future<void> Function();
typedef CallbackApp = List<VoidCallback> Function(BuildContext);

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_onAddPostFrameCallback);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (BuildContext context, Object? state) {},
      buildWhen: (previous, current) => previous.isDarkTheme != current.isDarkTheme,
      builder: (context, state) => MaterialApp(
        navigatorKey: locator<AppNavigator>().navigatorKey,
        title: AppEnvironment.title,
        debugShowCheckedModeBanner: false,
        theme: state.isDarkTheme ? ThemeManager.dark : ThemeManager.light,
        themeMode: ThemeManager.mode,
        darkTheme: ThemeManager.dark,
        onGenerateRoute: Routes.generateRoutes,
        initialRoute: PATHS.splash.route(),
        builder: locator<AppLoading>().init(),
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
      ),
    );
  }

  void _onAddPostFrameCallback(_) {
    PermissionLib()
      ..setup(context)
      ..requests([Permission.camera]);
  }
}
