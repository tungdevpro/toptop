import 'package:core/common/bloc/base_state.dart';
import 'package:video_player/video_player.dart';

class FeedState extends BaseState {
  final List<String> urls;
  final Map<int, VideoPlayerController> controllers;
  final int focusedIndex;
  final int reloadCounter;
  final bool isLoading;

  FeedState({required this.urls, required this.controllers, required this.focusedIndex, required this.reloadCounter, required this.isLoading});

  FeedState copyWith({
    List<String>? urls,
    Map<int, VideoPlayerController>? controllers,
    int? focusedIndex,
    int? reloadCounter,
    bool? isLoading,
  }) {
    return FeedState(
      urls: urls ?? this.urls,
      controllers: controllers ?? this.controllers,
      focusedIndex: focusedIndex ?? this.focusedIndex,
      reloadCounter: reloadCounter ?? this.reloadCounter,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  factory FeedState.initial() => FeedState(
        focusedIndex: 0,
        reloadCounter: 0,
        isLoading: false,
        urls: [],
        controllers: {},
      );

  @override
  List<Object?> get props => [urls, controllers, focusedIndex, reloadCounter, isLoading];
}
