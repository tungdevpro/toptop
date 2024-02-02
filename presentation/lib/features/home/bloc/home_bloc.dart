import 'package:injectable/injectable.dart';
import 'package:presentation/features/home/bloc/home_event.dart';
import 'package:presentation/features/home/bloc/home_state.dart';
import 'package:presentation/import.dart';

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
