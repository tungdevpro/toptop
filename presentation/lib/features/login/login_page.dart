import 'package:core/core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:presentation/core/app/app_bloc.dart';
import 'package:presentation/import.dart';
import 'package:presentation/features/login/bloc/login_bloc.dart';

import '../../common/widgets/app_header.dart';

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
    return Scaffold(
      appBar: AppHeader(),
      body: ListView(
        children: [
          TextFormField(),
          TextButton(
            onPressed: () {
              // throw Exception("this is lob");
              // bloc.add(LoginSubmittedEvent(email: 'vitester04@mailinator.com', password: 'Vi@@1234'));
              locator<AuthBloc>().add(SuccessAuthorizeEvent());
            },
            child: Text("Login --> ${AppStrings.navHome.tr()}"),
          ),
        ],
      ),
    );
  }
}
