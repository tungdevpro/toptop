library presentation;

import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:presentation/common/constants/app_configs.dart';
import 'package:presentation/common/routes/routes.dart';
import 'package:presentation/di/locator.dart';

class Presentation {
  static void init() async {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    Data.init();
    Domain.init();
    configureDependencies();
  }
}

abstract class GlobalConfiguration {
  static String get initRoute => PATHS.login.route();

  static Widget wrap(
    Widget child, {
    Locale? fallbackLocale,
    Locale? startLocale,
  }) {
    return EasyLocalization(
      supportedLocales: AppConfigs.supportedLocales,
      path: AppConfigs.pathTranslations,
      fallbackLocale: fallbackLocale ?? AppConfigs.fallbackLocale,
      startLocale: startLocale ?? AppConfigs.fallbackLocale,
      assetLoader: const YamlAssetLoader(),
      child: child,
    );
  }
}
