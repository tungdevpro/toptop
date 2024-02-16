import 'package:injectable/injectable.dart';
import 'package:presentation/features/feed/bloc/feed_event.dart';
import 'package:presentation/features/feed/bloc/feed_state.dart';
import 'package:presentation/import.dart';

@injectable
class FeedBloc extends BaseBloc<FeedEvent, FeedState> {
  FeedBloc() : super(FeedState());

  static FeedBloc get to => locator<FeedBloc>();

  @override
  void listEvent() {}
}
