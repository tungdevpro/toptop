import 'package:injectable/injectable.dart';
import 'package:presentation/features/profile/bloc/profile_event.dart';
import 'package:presentation/features/profile/bloc/profile_state.dart';
import 'package:presentation/import.dart';

@injectable
class ProfileBloc extends BaseBloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitialState());

  static ProfileBloc get to => locator<ProfileBloc>();

  @override
  void listEvent() {}
}
