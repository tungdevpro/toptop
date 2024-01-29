import 'dart:async';
import 'package:flutter/material.dart';

import '../common/widgets/custom_animated_dialog.dart';

abstract class AppDialogs {
  const AppDialogs._();

  static Future<dynamic> show(
    BuildContext context, {
    bool barrierDismissible = false,
    required WidgetBuilder builder,
    DialogTransitionMode animationType = DialogTransitionMode.fade,
    Curve curve = Curves.linear,
    Duration? duration,
    Alignment alignment = Alignment.center,
    Axis? axis,
    Color? barrierColor,
  }) {
    return animatedDialog(
      context,
      builder: builder,
      barrierColor: barrierColor,
      barrierDismissible: barrierDismissible,
      alignment: alignment,
      animationType: animationType,
      curve: curve,
      duration: duration,
      axis: axis,
    );
  }
}
