import 'package:presentation/import.dart';

import '../../common/widgets/app_header.dart';
import 'bloc/camera_bloc.dart';

class CameraPage extends StatefulWidget {
  final bool wantKeepAlive;
  const CameraPage({super.key, this.wantKeepAlive = false});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends CoreViewState<CameraPage, CameraBloc> with AutomaticKeepAliveClientMixin<CameraPage> {
  @override
  CameraBloc get initBloc => CameraBloc.to;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        appBar: AppHeader(text: 'Camera', leadingIcon: LeadingIcon.none, leadingWidth: 0),
      ),
    );
  }

  @override
  bool get wantKeepAlive => widget.wantKeepAlive;
}
