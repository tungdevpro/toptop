import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class BaseBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // dLog('[BLOC_CHANGE]: $bloc');
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('[BLOC_CREATE]: $bloc');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log('[BLOC_ERROR]: $error');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    // dLog('[BLOC TRANSITION]: $transition');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('[BLOC_CLOSE]: $bloc');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    // dLog('[BLOC_EVENT]: $bloc - $event');
  }
}
