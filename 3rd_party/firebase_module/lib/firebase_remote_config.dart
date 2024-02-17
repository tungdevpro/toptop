import 'package:firebase_remote_config/firebase_remote_config.dart';

class CustomFirebaseRemoteConfig {
  static final CustomFirebaseRemoteConfig _inst = CustomFirebaseRemoteConfig._internal();

  CustomFirebaseRemoteConfig._internal();

  factory CustomFirebaseRemoteConfig() {
    return _inst;
  }

  final remoteConfig = FirebaseRemoteConfig.instance;

  void fetch() async {
    final res = await remoteConfig.fetch();
  }
}
