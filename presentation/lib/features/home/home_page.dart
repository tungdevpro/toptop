import 'package:firebase_module/firebase_module.dart';
import 'package:presentation/common/widgets/app_header.dart';
import 'package:presentation/common/widgets/custom_button.dart';
import 'package:presentation/import.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(text: 'Home', leadingIcon: LeadingIcon.none, leadingWidth: 0),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: CustomButton(
                isFit: false,
                onPressed: () async {
                  final token = await FirebaseModule().getToken();
                  print('object... $token');
                },
                title: "Click",
              ),
            )
          ],
        ),
      ),
    );
  }
}
