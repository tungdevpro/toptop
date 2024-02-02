library telegram_bot;

import 'dart:math';

import 'package:telegram_bot/constants.dart' as constants;
import 'package:telegram_bot/telegram_bot_interface.dart';
import 'package:http/http.dart' as http;

class TelegramBot implements TelegramBotInterface {
  String _limitMessage(final String message) => message.substring(0, min(4096, message.length));

  @override
  Future<http.Response?> send([String? messsage, StackTrace? stack]) async {
    var stackLines = stack?.toString().split('\n');
    var firstStackTraceLine = stackLines?[0].trim();
    String? from;
    final regx = RegExp(r'\(package:pre.+\)');
    final _ = firstStackTraceLine?.replaceAllMapped(regx, (match) {
      from = match.group(0);
      return '';
    });

    final uri = Uri.https(
      "api.telegram.org",
      "/bot${constants.token}/sendMessage",
      {
        "chat_id": '@toptop_v2_reporting_channel',
        "text": _limitMessage('$messsage: $from'),
        "parse_mode": "html",
      },
    );
    return http.get(uri);
  }
}
