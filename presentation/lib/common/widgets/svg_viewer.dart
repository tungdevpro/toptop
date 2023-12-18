import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgViewer extends StatelessWidget {
  final String assetName;
  final BoxFit fit;
  final double? width;
  final double? height;
  const SvgViewer(this.assetName, {super.key, this.fit = BoxFit.contain, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      package: 'presentation',
      fit: fit,
      width: width,
      height: height,
    );
  }
}
