import 'package:injectable/injectable.dart';
import 'package:presentation/features/profile/bloc/profile_event.dart';
import 'package:presentation/features/profile/bloc/profile_state.dart';
import 'package:presentation/import.dart';

@injectable
class CameraBloc extends BaseBloc<ProfileEvent, ProfileState> {
  CameraBloc() : super(ProfileInitialState());

  static CameraBloc get to => locator<CameraBloc>();

  @override
  void listEvent() {}
}
