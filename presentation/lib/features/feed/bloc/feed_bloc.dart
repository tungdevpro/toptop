import 'dart:async';

import 'package:core/common/bloc/base_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:presentation/di/locator.dart';
import 'package:presentation/features/feed/feed.dart';

@Injectable()
class FeedBloc extends BaseBloc<FeedEvent, FeedState> {
  FeedBloc() : super(FeedState.initial());

  static FeedBloc get to => locator<FeedBloc>();

  @override
  void listEvent() {
    on<FeedGetVideoFromApiEvent>(_onFeedGetVideoFromApiEvent);
    on<FeedLoadingEvent>(_onFeedLoadingEvent);
    on<FeedSetupUrlEvent>(_onFeedSetupUrlEvent);
    on<FeedVideoIndexChangedEvent>(_onFeedVideoIndexChangedEvent);
  }

  void _onFeedGetVideoFromApiEvent(FeedGetVideoFromApiEvent event, Emitter<FeedState> emit) {}

  void _onFeedLoadingEvent(FeedLoadingEvent event, Emitter<FeedState> emit) {}

  FutureOr<void> _onFeedSetupUrlEvent(FeedSetupUrlEvent event, Emitter<FeedState> emit) {}

  FutureOr<void> _onFeedVideoIndexChangedEvent(FeedVideoIndexChangedEvent event, Emitter<FeedState> emit) {}
}
