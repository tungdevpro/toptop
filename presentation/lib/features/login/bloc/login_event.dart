import 'package:core/common/bloc/base_event.dart';

abstract class LoginEvent extends BaseEvent {}

class LoginEmailChangedEvent extends LoginEvent {
  final String email;
  LoginEmailChangedEvent(this.email);

  @override
  List<Object?> get props => [email];
}

class LoginPasswordChangedEvent extends LoginEvent {
  final String password;
  LoginPasswordChangedEvent(this.password);

  @override
  List<Object?> get props => [password];
}

class LoginSubmittedEvent extends LoginEvent {
  final String email;
  final String password;

  LoginSubmittedEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class LoginTogglePasswordEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}
