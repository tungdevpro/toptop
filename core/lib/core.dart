library core;

import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/bloc/base_bloc_observer.dart';
import 'di/locator.dart';

class Core {
  static void init() {
    Bloc.observer = BaseBlocObserver();
    configureDependencies();
  }
}
