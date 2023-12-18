import 'package:core/core/core.dart';
import 'package:flutter/material.dart';
import 'package:presentation/features/login/bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends CoreViewState<LoginPage, LoginBloc> {
  @override
  LoginBloc get initBloc => LoginBloc.to;

  @override
  Widget build(BuildContext context) {
    print('object');
    return Scaffold(
      body: ListView(
        children: [
          Text('data--- ${bloc}'),
        ],
      ),
    );
  }
}
