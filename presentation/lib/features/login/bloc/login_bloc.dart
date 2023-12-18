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

@Injectable()
class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;

  LoginBloc(this._loginUseCase) : super(LoginState(status: LoginStatus.none));

  static LoginBloc get to => locator<LoginBloc>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    final emailModel = EmailValidateModel.dirty(event.email);
    emit(state.copyWith(status: LoginStatus.validating, email: emailModel));
  }

  void _onPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) {
    final pwdModel = PasswordValidateModel.dirty(event.password);
    emit(state.copyWith(status: LoginStatus.validating, password: pwdModel));
  }

  void _onSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    _loginUseCase.performLogin(LoginRequestModel(email: emailController.text, password: passwordController.text));
  }

  void _onTogglePasswordEvent(LoginTogglePasswordEvent event, Emitter<LoginState> emit) {}

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }

  @override
  void listEvent() {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginTogglePasswordEvent>(_onTogglePasswordEvent);
  }
}
