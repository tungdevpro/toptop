library presentation;

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_module/firebase_module.dart';
// import 'package:firebase_module/firebase_module.dart';
import 'package:flutter/services.dart';
import 'package:presentation/application.dart';
import 'package:presentation/common/helpers/custom_easy_localization_yaml.dart';
import 'package:presentation/import.dart';

abstract class Presentation {
  const Presentation._();

  static void init() async {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    await EasyLocalization.ensureInitialized();
    await FirebaseModule().initialize();

    Data.init();
    Domain.init();
    configureDependencies();
    _initApp();
  }
}

void _initApp() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(EasyLocalization(
      supportedLocales: AppLangs.supportedLocales,
      path: AppLangs.unused,
      fallbackLocale: AppLangs.fallbackLocale,
      startLocale: AppLangs.fallbackLocale,
      assetLoader: const CustomYamlAssetLoader(directory: AppLangs.path, package: AppConfigs.packageName),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthBloc.to..add(const AuthInitialEvent())),
          BlocProvider(
              create: (_) => AppBloc.to
                ..add(AppCheckSkipIntroEvent())
                ..add(AppGetConfigEvent())),
        ],
        child: const Application(),
      ),
    ));
  });
}
