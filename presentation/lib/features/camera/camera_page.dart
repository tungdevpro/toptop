import 'package:presentation/import.dart';

import 'bloc/camera_bloc.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends CoreViewState<CameraPage, CameraBloc> {
  @override
  CameraBloc get initBloc => CameraBloc.to;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(),
    );
  }
}
