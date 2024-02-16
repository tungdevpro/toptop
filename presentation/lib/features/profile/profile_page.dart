import 'package:presentation/features/profile/bloc/profile_bloc.dart';
import 'package:presentation/import.dart';

import '../../common/widgets/app_header.dart';

class ProfilePage extends StatefulWidget {
  final bool wantKeepAlive;
  const ProfilePage({super.key, this.wantKeepAlive = false});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends CoreViewState<ProfilePage, ProfileBloc> with AutomaticKeepAliveClientMixin<ProfilePage> {
  @override
  ProfileBloc get initBloc => ProfileBloc.to;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        appBar: AppHeader(text: 'Profile', leadingIcon: LeadingIcon.none, leadingWidth: 0),
      ),
    );
  }

  @override
  bool get wantKeepAlive => widget.wantKeepAlive;
}
