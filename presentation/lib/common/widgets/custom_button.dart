import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:presentation/common/constants/app_sizings.dart';

import '../constants/app_colors.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool isElevation;
  final Widget? child;
  final Color backgroundColor;
  final Color? colorTitle;
  final double borderRadius;
  final double elevation;
  final double scaleBegin, scaleEnd;
  final double? width, height;
  final int duration;
  final EdgeInsetsGeometry? padding;
  final dynamic title;
  final bool isFit;
  final TextStyle? styleTitle;
  final bool isDisable;
  final BoxBorder? border;

  const CustomButton({
    Key? key,
    this.child,
    this.onPressed,
    this.backgroundColor = AppColors.primary,
    this.duration = 1000,
    this.borderRadius = AppSizings.radius,
    this.elevation = 4,
    this.padding,
    this.isElevation = true,
    this.scaleBegin = .95,
    this.scaleEnd = 1,
    this.width,
    this.height,
    this.colorTitle,
    this.title,
    this.isFit = false,
    this.styleTitle,
    this.isDisable = false,
    this.border,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _ScaleBtnCompState();
}

class _ScaleBtnCompState extends State<CustomButton> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late bool isDisable;

  @override
  void initState() {
    super.initState();
    isDisable = widget.isDisable;

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
      value: 1,
    );

    animation = Tween(
      begin: widget.scaleBegin,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.elasticOut,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant CustomButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isDisable != widget.isDisable) {
      isDisable = widget.isDisable;
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _pressed(_) {
    if (isDisable) return;
    animationController.value = 0;
  }

  Future<void> _unPressedOnTapUp(_) async {
    if (isDisable) return;
    animationController.forward();
    await Future.delayed(const Duration(milliseconds: 100));
    widget.onPressed?.call();
    animationController.value = 1;
  }

  Future<void> _unPressed() async {
    if (isDisable) return;
    animationController.value = 1;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _pressed,
      onTapUp: _unPressedOnTapUp,
      onTapCancel: _unPressed,
      child: AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? cachedChild) {
          return AnimatedScale(
            duration: const Duration(milliseconds: 500),
            scale: animation.value,
            child: widget.child ??
                Container(
                  decoration: BoxDecoration(color: widget.backgroundColor, borderRadius: BorderRadius.circular(widget.borderRadius), border: widget.border),
                  padding: widget.padding,
                  height: !widget.isFit ? (widget.height ?? 50) : null,
                  alignment: Alignment.center,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
                    child: isDisable
                        ? Lottie.asset("assets/animations/circle_loading.json")
                        : (widget.title is Widget
                            ? widget.title
                            : Text('${widget.title}', style: widget.styleTitle ?? TextStyle(color: widget.colorTitle ?? Colors.white))),
                  ),
                ),
          );
        },
      ),
    );
  }
}
