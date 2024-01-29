import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

class CustomYamlAssetLoader extends AssetLoader {
  final String? package;

  final String directory;

  const CustomYamlAssetLoader({required this.directory, this.package});

  @override
  // ignore: avoid_renaming_method_parameters
  Future<Map<String, dynamic>> load(String basePath, Locale locale) async {
    final localePath = getFilePath(locale, basePath: basePath);
    final yamlMap = loadYaml(await rootBundle.loadString(localePath));
    return _yamlMapToMap(yamlMap);
  }

  String getFilePath(Locale locale, {required String basePath}) {
    if (package == null) return '$directory/$locale.yaml';

    return 'packages/$package/$directory/$locale.yaml';
  }

  Map<String, dynamic> _yamlMapToMap(YamlMap yamlMap) {
    return yamlMap.map(
      (k, v) => MapEntry(
        k.toString(),
        v is YamlMap ? _yamlMapToMap(v) : v.toString(),
      ),
    );
  }
}
