import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  final double height;
  const Gap(this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
