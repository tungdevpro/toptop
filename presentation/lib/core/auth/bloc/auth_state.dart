import 'package:domain/model/user_model.dart';
import 'package:equatable/equatable.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  final UserModel? user;
  final AuthStatus status;

  const AuthState._({this.status = AuthStatus.unknown, this.user});

  const AuthState.unknown() : this._();

  const AuthState.authenticated(UserModel user) : this._(status: AuthStatus.authenticated, user: user);

  const AuthState.unauthenticated() : this._(status: AuthStatus.unauthenticated);

  @override
  List<Object?> get props => [user, status];
}
