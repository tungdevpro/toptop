import 'dart:async';

import 'package:domain/model/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:presentation/import.dart';

@singleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.unknown()) {
    on<AuthInitialEvent>(_onAuthInitialEvent);
    on<NotAuthorizeEvent>(_onNotAuthorizeEvent);
    on<SuccessAuthorizeEvent>(_onSuccessAuthorizeEvent);
  }

  late AuthCacheManager cache;

  static AuthBloc get to => locator<AuthBloc>();

  void _onAuthInitialEvent(AuthInitialEvent event, Emitter<AuthState> emit) async {
    cache = AuthCacheManager();
    // Using delay to avoid miss cache
    await Future.delayed(const ExtraShortDuration(), () async {
      final isLoggedIn = await cache.isLoggedIn();
      emit(isLoggedIn ? AuthState.authenticated(UserModel()) : const AuthState.unauthenticated());
    });
  }

  void _onNotAuthorizeEvent(NotAuthorizeEvent event, Emitter<AuthState> emit) {
    cache.clear();
    emit(const AuthState.unauthenticated());
  }

  void _onSuccessAuthorizeEvent(SuccessAuthorizeEvent event, Emitter<AuthState> emit) {
    cache.saveAcc();
    emit(AuthState.authenticated(UserModel()));
  }
}
