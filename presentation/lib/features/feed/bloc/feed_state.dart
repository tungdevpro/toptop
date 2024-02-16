import 'package:presentation/import.dart';

class FeedState extends BaseState {
  final ViewStateStatus status;
  FeedState({this.status = ViewStateStatus.empty});

  FeedState copyWith(ViewStateStatus? status) {
    return FeedState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
