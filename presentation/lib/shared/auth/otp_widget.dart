import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:pinput/pinput.dart';
import 'package:presentation/import.dart';

class OtpWidget extends StatefulWidget {
  final AsyncCallback? onResend;
  const OtpWidget({Key? key, this.onResend}) : super(key: key);

  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  final focusedBorderColor = AppColors.primary;
  final fillColor = const Color.fromRGBO(243, 246, 249, 0);
  final borderColor = const Color(0xFFDADADA);

  PinTheme get defaultPinTheme => PinTheme(
        width: 52,
        height: 60,
        textStyle: const TextStyle(fontSize: 22, color: Color.fromRGBO(30, 60, 87, 1)),
        decoration: BoxDecoration(color: AppColors.inputField, borderRadius: BorderRadius.circular(10), border: Border.all(color: borderColor)),
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
      );

  Timer? _timer;
  final ValueNotifier<int> _startNotifier = ValueNotifier(sec);
  final _hasResendNotifier = ValueNotifier(false);

  static int sec = 5;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    _startNotifier.dispose();
    _hasResendNotifier.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: formKey,
          child: Pinput(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            length: 6,
            autofocus: true,
            controller: pinController,
            focusNode: focusNode,
            androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
            listenForMultipleSmsOnAndroid: true,
            defaultPinTheme: defaultPinTheme,
            hapticFeedbackType: HapticFeedbackType.lightImpact,
            onCompleted: (pin) {
              debugPrint('onCompleted: $pin');
            },
            onChanged: (value) {
              debugPrint('onChanged: $value');
            },
            cursor: Container(width: 1, height: 20, color: focusedBorderColor),
            focusedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(borderRadius: BorderRadius.circular(10), border: Border.all(color: focusedBorderColor)),
            ),
            submittedPinTheme: defaultPinTheme.copyWith(
                // decoration:
                // defaultPinTheme.decoration!.copyWith(color: fillColor, borderRadius: BorderRadius.circular(10), border: Border.all(color: focusedBorderColor)),
                ),
            errorPinTheme: defaultPinTheme.copyBorderWith(border: Border.all(color: Colors.redAccent)),
          ),
        ),
        const Gap(20),
        ValueListenableBuilder<bool>(
          valueListenable: _hasResendNotifier,
          builder: (context, hasSend, child) => hasSend
              ? GestureDetector(
                  onTap: _onResend,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(AppStrings.authResendOTPLater.tr(args: ['']),
                        style: const TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.bold)),
                  ),
                )
              : RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(fontSize: 13, color: Color(0xffB2B2B2), height: 22 / 13, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(text: AppStrings.authResendOTPLater.tr(args: [' ${AppStrings.later.tr()}: '])),
                      WidgetSpan(
                        child: ValueListenableBuilder<int>(
                          valueListenable: _startNotifier,
                          builder: (context, value, child) => Text(
                            '$value' 's',
                            style: const TextStyle(color: AppColors.textBody, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_startNotifier.value < 1) {
        _hasResendNotifier.value = true;
        timer.cancel();
      } else {
        _startNotifier.value = _startNotifier.value - 1;
      }
    });
  }

  void _onResend() async {
    context.hideKeyboard();
    await widget.onResend?.call();
    _startNotifier.value = sec;
    _hasResendNotifier.value = false;
    startTimer();
  }
}
