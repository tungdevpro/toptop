library core;

export 'common/common.dart';
export 'core/core.dart';
export 'globals.dart';
export 'utils/utils.dart';

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram_bot/telegram_bot.dart';
import 'common/bloc/base_bloc_observer.dart';
import 'core/cache_manager.dart';
import 'di/locator.dart';

abstract class Core {
  const Core._();

  static Future<void> init() async {
    await CacheManager.ensureInitialized();

    HttpOverrides.global = MyHttpOverrides();
    telegramBot = TelegramBot();
    Bloc.observer = BaseBlocObserver();
    configureDependencies();
  }

  static late TelegramBot telegramBot;

  static void onError(FlutterErrorDetails details) {
    debugPrint("----------FlutterError------------");
    debugPrint("Error :  ${details.exception}");
    debugPrint("StackTrace :  ${details.stack}");
    // telegramBot.send('${details.exception}', details.stack);
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
