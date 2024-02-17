import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core/service/app_navigator.dart';
import 'package:presentation/features/splash/components/splash_content_comp.dart';
import 'package:presentation/import.dart';

import '../../common/widgets/no_network_screen.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (!state.hasSkipIntro) {
          print('1111..... ${state.hasSkipIntro}');
          // locator<AppNavigator>().pushNamed(routeName)
        }
      },
      child: BlocSelector<AppBloc, AppState, bool>(
        selector: (state) => state.hasCheckNetworkGlobal,
        builder: (context, state) {
          if (!state) return const SplashContentComp();
          return StreamBuilder<ConnectivityResult>(
            stream: context.watch<AppBloc>().connectivityStream,
            builder: (context, snapshot) {
              final isConnected = [ConnectivityResult.wifi, ConnectivityResult.ethernet, ConnectivityResult.mobile].contains(snapshot.data);
              return Stack(
                fit: StackFit.expand,
                children: [
                  const SplashContentComp(),
                  if (!isConnected && snapshot.connectionState != ConnectionState.waiting) const NoNetworkScreen(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
