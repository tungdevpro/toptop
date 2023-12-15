library presentation;

import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:presentation/di/locator.dart';

class Presentation {
  static void init() {
    Data.init();
    Domain.init();
    configureDependencies();
  }
}
