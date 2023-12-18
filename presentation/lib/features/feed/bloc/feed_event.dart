import 'package:core/common/bloc/base_event.dart';

abstract class FeedEvent extends BaseEvent {}

class FeedGetVideoFromApiEvent extends FeedEvent {
  @override
  List<Object?> get props => [];
}

class FeedLoadingEvent extends FeedEvent {
  @override
  List<Object?> get props => [];
}

class FeedSetupUrlEvent extends FeedEvent {
  final List<String>? urls;

  FeedSetupUrlEvent({this.urls});
  @override
  List<Object?> get props => [urls];
}

class FeedVideoIndexChangedEvent extends FeedEvent {
  final int? index;

  FeedVideoIndexChangedEvent({this.index});
  @override
  List<Object?> get props => [index];
}
