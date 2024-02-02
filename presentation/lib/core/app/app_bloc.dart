import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:domain/usecase/config/get_config_app_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:presentation/import.dart';

@singleton
class AppBloc extends Bloc<AppEvent, AppState> implements LibraryInitializer {
  final GetConfigAppUseCase _getConfigAppUseCase;
  final AuthBloc authBloc;
  AppBloc(this._getConfigAppUseCase, this.authBloc) : super(const AppState(hasCheckNetworkGlobal: false)) {
    on<AppGetConfigEvent>(_onAppGetConfigEvent);
    on<AppRetryConnectNetworkEvent>(_onAppRetryConnectNetworkEvent);
  }
  late Stream<ConnectivityResult> connectivityStream;
  late StreamSubscription<AuthState> _authBlocSubscription;

  static AppBloc get to => locator<AppBloc>()..init();

  @override
  Future<void> init() async {
    connectivityStream = Connectivity().onConnectivityChanged;
    _authBlocSubscription = authBloc.stream.listen((event) {
      debugPrint('event---> $event');
    });

    final _ = await CacheManager.get(AppKeyCaches.introOff.path);
  }

  void _onAppGetConfigEvent(AppGetConfigEvent event, Emitter<AppState> emit) async {
    // final Result<ConfigModel> response = await _getConfigAppUseCase.getConfig();
    // if (!response.isSuccessful) {
    //   return;
    // }

    // emit(state.copyWith(config: (response as AppSuccess<ConfigModel>).data));
  }

  // Handle error when cant access network
  void _onAppRetryConnectNetworkEvent(AppRetryConnectNetworkEvent event, Emitter<AppState> emit) {}

  @override
  Future<void> close() {
    _authBlocSubscription.cancel();
    return super.close();
  }
}
