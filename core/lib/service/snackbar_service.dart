import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'dart:async';

typedef ControllerCallback = void Function(AnimationController);

enum DismissType { onSwipe, none }

enum SnackbarStatus {
  info('Thông báo', Colors.blue, Icon(Icons.info, color: Colors.white)),
  success('Thành công', Colors.green, Icon(Icons.expand_circle_down_outlined, color: Colors.white)),
  failure('Có lỗi', Colors.red, Icon(Icons.error, color: Colors.white));

  const SnackbarStatus(this.text, this.color, this.icon);
  final String text;
  final Color color;
  final dynamic icon;
}

@lazySingleton
class SnackbarService {
  // void show(BuildContext context, String message, {BoxDecoration? iconWithDecoration, Color? backgroundColor, Icon? icon, TextStyle? textStyle}) {

  void show(BuildContext context, String message, {SnackbarStatus status = SnackbarStatus.info}) {
    AnimationController? localAnimationController;

    _buildSnackbar(
      animationDuration: const Duration(milliseconds: 1000),
      reverseAnimationDuration: const Duration(milliseconds: 350),
      displayDuration: const Duration(milliseconds: 2000),
      onCreateAnimationController: (controller) => localAnimationController = controller,
      dismissType: DismissType.onSwipe,
      dismissDirection: [DismissDirection.horizontal, DismissDirection.vertical, DismissDirection.endToStart, DismissDirection.up, DismissDirection.startToEnd],
      Overlay.of(context),
      CustomSnackbarWidget(
        onCloseClick: () => localAnimationController?.reverse(),
        // icon: icon,
        // iconWithDecoration: iconWithDecoration,
        message: message,
        status: status,
        // textStyle: textStyle ?? Theme.of(context).textTheme.bodyMedium!.merge(const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white)),
        // backgroundColor: status.color,
      ),
    );
  }

  void _buildSnackbar(
    OverlayState overlayState,
    Widget child, {
    Duration animationDuration = const Duration(milliseconds: 1200),
    Duration reverseAnimationDuration = const Duration(milliseconds: 550),
    Duration displayDuration = const Duration(milliseconds: 3000),
    VoidCallback? onTap,
    bool persistent = false,
    ControllerCallback? onCreateAnimationController,
    EdgeInsets padding = const EdgeInsets.all(16),
    Curve curve = Curves.elasticOut,
    Curve reverseCurve = Curves.linearToEaseOut,
    DismissType dismissType = DismissType.onSwipe,
    List<DismissDirection> dismissDirection = const [DismissDirection.up],
  }) {
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (_) {
        return _TopSnackBar(
          onDismissed: () {
            overlayEntry.remove();
            _previousEntry = null;
          },
          animationDuration: animationDuration,
          reverseAnimationDuration: reverseAnimationDuration,
          displayDuration: displayDuration,
          onTap: onTap,
          persistent: persistent,
          onCreateAnimationController: onCreateAnimationController,
          padding: padding,
          curve: curve,
          reverseCurve: reverseCurve,
          dismissType: dismissType,
          dismissDirections: dismissDirection,
          child: child,
        );
      },
    );

    if (_previousEntry != null && _previousEntry!.mounted) _previousEntry?.remove();

    overlayState.insert(overlayEntry);
    _previousEntry = overlayEntry;
  }
}

class CustomSnackbarWidget extends StatefulWidget {
  final String message;
  final VoidCallback? onCloseClick;
  final Icon? icon;
  final BoxDecoration? iconWithDecoration;
  final SnackbarStatus status;

  const CustomSnackbarWidget({
    Key? key,
    required this.message,
    this.onCloseClick,
    this.icon,
    this.iconWithDecoration,
    this.status = SnackbarStatus.info,
  }) : super(key: key);

  @override
  CustomSnackbarWidgetState createState() => CustomSnackbarWidgetState();
}

class CustomSnackbarWidgetState extends State<CustomSnackbarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      // height: 60,
      constraints: const BoxConstraints(minHeight: 50),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(color: widget.status.color, borderRadius: const BorderRadius.all(Radius.circular(12))),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.status.icon != null) ...[
            if (widget.status.icon is Widget) widget.status.icon,
            const SizedBox(width: 5),
          ],
          Text(widget.message,
              style: const TextStyle(color: Colors.white, fontSize: 14), textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, maxLines: 2),
        ],
      ),
    );
  }
}

OverlayEntry? _previousEntry;

class _TopSnackBar extends StatefulWidget {
  const _TopSnackBar({
    Key? key,
    required this.child,
    required this.onDismissed,
    required this.animationDuration,
    required this.reverseAnimationDuration,
    required this.displayDuration,
    required this.padding,
    required this.curve,
    required this.reverseCurve,
    required this.dismissDirections,
    this.onTap,
    this.persistent = false,
    this.onCreateAnimationController,
    this.dismissType = DismissType.onSwipe,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onDismissed;
  final Duration animationDuration;
  final Duration reverseAnimationDuration;
  final Duration displayDuration;
  final VoidCallback? onTap;
  final ControllerCallback? onCreateAnimationController;
  final bool persistent;
  final EdgeInsets padding;
  final Curve curve;
  final Curve reverseCurve;
  final DismissType dismissType;
  final List<DismissDirection> dismissDirections;

  @override
  _TopSnackBarState createState() => _TopSnackBarState();
}

class _TopSnackBarState extends State<_TopSnackBar> with SingleTickerProviderStateMixin {
  late final Animation<Offset> _offsetAnimation;
  late final AnimationController _animationController;

  Timer? _timer;

  final _offsetTween = Tween(begin: const Offset(0, -1), end: Offset.zero);

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
      reverseDuration: widget.reverseAnimationDuration,
    );
    _animationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed && !widget.persistent) {
          _timer = Timer(widget.displayDuration, () {
            if (mounted) {
              _animationController.reverse();
            }
          });
        }
        if (status == AnimationStatus.dismissed) {
          _timer?.cancel();
          widget.onDismissed.call();
        }
      },
    );

    widget.onCreateAnimationController?.call(_animationController);

    _offsetAnimation = _offsetTween.animate(CurvedAnimation(parent: _animationController, curve: widget.curve, reverseCurve: widget.reverseCurve));
    if (mounted) _animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.padding.top,
      left: widget.padding.left,
      right: widget.padding.right,
      child: SlideTransition(position: _offsetAnimation, child: SafeArea(child: _buildDismissibleChild())),
    );
  }

  Widget _buildDismissibleChild() {
    switch (widget.dismissType) {
      case DismissType.onSwipe:
        var childWidget = widget.child;
        for (final direction in widget.dismissDirections) {
          childWidget = Dismissible(
            direction: direction,
            key: UniqueKey(),
            dismissThresholds: const {DismissDirection.up: 0.2},
            confirmDismiss: (direction) async {
              if (!widget.persistent && mounted) {
                if (direction == DismissDirection.down) {
                  await _animationController.reverse();
                } else {
                  _animationController.reset();
                }
              }
              return false;
            },
            child: childWidget,
          );
        }
        return childWidget;
      case DismissType.none:
        return widget.child;
    }
  }
}
