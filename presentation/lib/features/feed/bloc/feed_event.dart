import 'package:presentation/import.dart';

abstract class FeedEvent extends BaseEvent {}

class FeedFetchingEvent extends FeedEvent {
  @override
  List<Object?> get props => [];
}

class FeedLoadedSuccessEvent extends FeedEvent {
  @override
  List<Object?> get props => [];
}
