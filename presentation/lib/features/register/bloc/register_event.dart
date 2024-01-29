import 'package:core/common/bloc/base_event.dart';

import 'register_state.dart';

abstract class RegisterEvent extends BaseEvent {}

class RegisterFullNameChanged extends RegisterEvent {
  final String fullName;

  RegisterFullNameChanged(this.fullName);

  @override
  List<Object?> get props => [fullName];
}

class RegisterEmailChangedEvent extends RegisterEvent {
  final String email;
  RegisterEmailChangedEvent(this.email);

  @override
  List<Object?> get props => [email];
}

class RegisterChangeStepEvent extends RegisterEvent {
  final StepRegister step;
  RegisterChangeStepEvent(this.step);

  @override
  List<Object?> get props => [step];
}

class RegisterPasswordChangedEvent extends RegisterEvent {
  final String password;
  RegisterPasswordChangedEvent(this.password);

  @override
  List<Object?> get props => [password];
}

class RegisterConfirmPasswordChangedEvent extends RegisterEvent {
  final String confirmPassword;
  RegisterConfirmPasswordChangedEvent(this.confirmPassword);

  @override
  List<Object?> get props => [confirmPassword];
}

class RegisterNextStepCompleteEvent extends RegisterEvent {
  final bool isNextComplete;
  RegisterNextStepCompleteEvent(this.isNextComplete);

  @override
  List<Object?> get props => [isNextComplete];
}

class RegisterSubmittedEvent extends RegisterEvent {
  final String email;
  final String fullName;
  final String password;

  RegisterSubmittedEvent({required this.email, required this.fullName, required this.password});

  @override
  List<Object?> get props => [email, fullName, password];
}
