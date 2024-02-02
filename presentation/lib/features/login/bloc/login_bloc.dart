import 'dart:async';

import 'package:core/common/bloc/base_bloc.dart';
import 'package:core/di/locator.dart';
import 'package:domain/model/login_request_model.dart';
import 'package:domain/usecase/login/login_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../common/validators/email_validate.dart';
import '../../../common/validators/password_validate.dart';
import 'login_event.dart';
import 'login_state.dart';

@injectable
class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;

  LoginBloc(@Named('LoginUseCaseImpl') this._loginUseCase) : super(LoginState(status: LoginStatus.none));

  static LoginBloc get to => locator<LoginBloc>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _onEmailChanged(LoginEmailChangedEvent event, Emitter<LoginState> emit) {
    final emailModel = EmailValidateModel.dirty(event.email);
    emit(state.copyWith(status: LoginStatus.validating, email: emailModel));
  }

  void _onPasswordChanged(LoginPasswordChangedEvent event, Emitter<LoginState> emit) {
    final pwdModel = PasswordValidateModel.dirty(event.password);
    emit(state.copyWith(status: LoginStatus.validating, password: pwdModel));
  }

  void _onSubmitted(LoginSubmittedEvent event, Emitter<LoginState> emit) async {
    showLoading();
    final result = await _loginUseCase.performLogin(LoginRequestModel(email: event.email, password: event.password));
    hideLoading();
    result.when();
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }

  @override
  void listEvent() {
    on<LoginEmailChangedEvent>(_onEmailChanged);
    on<LoginPasswordChangedEvent>(_onPasswordChanged);
    on<LoginSubmittedEvent>(_onSubmitted);
    on<LoginTogglePasswordEvent>(_onTogglePasswordEvent);
  }

  void _onTogglePasswordEvent(LoginTogglePasswordEvent event, Emitter<LoginState> emit) {}
}
