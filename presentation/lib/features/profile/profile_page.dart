import 'package:presentation/features/profile/bloc/profile_bloc.dart';
import 'package:presentation/import.dart';

import '../../common/widgets/app_header.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends CoreViewState<ProfilePage, ProfileBloc> {
  @override
  ProfileBloc get initBloc => ProfileBloc.to;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        appBar: AppHeader(text: 'Profile', leadingIcon: LeadingIcon.none, leadingWidth: 0),
      ),
    );
  }
}
