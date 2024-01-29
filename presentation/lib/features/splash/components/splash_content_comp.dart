import 'package:core/service/app_navigator.dart';
import 'package:presentation/features/home/home.dart';
import 'package:presentation/features/login/login.dart';
import 'package:presentation/import.dart';

import '../../../common/widgets/custom_button.dart';
import '../../register/register_page.dart';

class SplashContentComp extends StatefulWidget {
  const SplashContentComp({super.key});

  @override
  State<SplashContentComp> createState() => _SplashContentCompState();
}

class _SplashContentCompState extends State<SplashContentComp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          // locator<AppNavigator>().pushNamed(PATHS.home.route());
        }
      },
      builder: (context, state) {
        return AnimatedSwitcher(
          transitionBuilder: _buildTransition,
          duration: const ShortDuration(),
          child: state.status == AuthStatus.unauthenticated ? const RegisterPage() : _buildBody(),
          // child: HomePage(),
        );
      },
    );
  }

  Widget _buildBody() {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary)),
        ),
      ),
    );
  }

  Widget _buildTransition(Widget child, Animation<double> animation) {
    return FadeTransition(opacity: animation, child: child);
  }
}
