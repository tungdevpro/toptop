import 'package:core/common/bloc/base_bloc.dart';
import 'package:presentation/features/home/bloc/home_event.dart';
import 'package:presentation/features/home/bloc/home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState());

  @override
  void listEvent() {}
}
