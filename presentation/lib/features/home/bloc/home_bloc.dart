import 'dart:async';

import 'package:bloc/src/bloc.dart';
import 'package:core/common/bloc/base_bloc.dart';
import 'package:core/di/locator.dart';
import 'package:injectable/injectable.dart';
import 'package:presentation/features/home/bloc/home_event.dart';
import 'package:presentation/features/home/bloc/home_state.dart';

@Injectable()
class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState());

  static HomeBloc get to => locator<HomeBloc>();

  @override
  void listEvent() {
    on<HomeFetchingEvent>(_onHomeFetchingEvent);
  }

  void _onHomeFetchingEvent(HomeFetchingEvent event, Emitter<HomeState> emit) {}
}
