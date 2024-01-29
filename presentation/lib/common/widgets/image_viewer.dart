import 'package:presentation/import.dart';

class ImageViewer extends StatelessWidget {
  final String url;
  final double? width, height;
  final BoxFit fit;
  const ImageViewer(this.url, {super.key, this.width, this.height, this.fit = BoxFit.contain});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      url,
      package: AppConfigs.packageName,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
