import 'package:presentation/import.dart';

class NoNetworkScreen extends StatelessWidget {
  const NoNetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: .0,
        // systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(child: Text('No internet connection')),
              TextButton(onPressed: () => _onPressed(context), child: const Text("Retry")),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressed(BuildContext context) {
    locator<AppBloc>().add(AppRetryConnectNetworkEvent());
  }
}
