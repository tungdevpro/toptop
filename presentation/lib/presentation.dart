library presentation;

import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:presentation/di/locator.dart';

class Presentation {
  static void init() async {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    Data.init();
    Domain.init();
    configureDependencies();
  }
}
