import 'package:http/http.dart' as http;

abstract class TelegramBotInterface {
  Future<http.Response?> send([String? text, StackTrace? stack]);
}
