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
      body: const Center(child: Text('Happy new year 2024 <3')),
    );
  }
}
