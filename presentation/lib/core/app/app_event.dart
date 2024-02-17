import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {}

class AppGetConfigEvent extends AppEvent {
  @override
  List<Object?> get props => [];
}

class AppCheckSkipIntroEvent extends AppEvent {
  @override
  List<Object?> get props => [];
}

class AppRetryConnectNetworkEvent extends AppEvent {
  @override
  List<Object?> get props => [];
}

class AppPushNotifyEvent extends AppEvent {
  @override
  List<Object?> get props => [];
}
