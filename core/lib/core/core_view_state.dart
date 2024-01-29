import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/bloc/base_bloc.dart';
import '../common/bloc/base_event.dart';
import '../common/bloc/base_state.dart';

abstract class CoreViewState<P extends StatefulWidget, T extends BaseBloc<BaseEvent, BaseState>> extends State<P> {
  T? _bloc;

  T get bloc => _bloc!;

  @override
  void initState() {
    super.initState();
    _bloc = initBloc;
    _bloc?.setContext(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc?.navigator.setContext(context);
      _bloc?.initialRouteSetting(ModalRoute.of(context)?.settings);
    });
  }

  T get initBloc => context.read<T>();

  @override
  void dispose() {
    _bloc?.close();
    super.dispose();
  }
}
