import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:presentation/common/constants/app_images.dart';
import 'package:presentation/common/constants/app_sizings.dart';
import 'package:presentation/common/widgets/custom_button.dart';
import 'package:presentation/common/widgets/image_viewer.dart';
import 'package:presentation/import.dart';

import 'otp_widget.dart';

class AuthOTPModalPopupWidget extends StatefulWidget {
  final String? title;
  final String email;
  final VoidCallback? onConfirm;
  final AsyncCallback? onResend;
  const AuthOTPModalPopupWidget({super.key, this.title, required this.email, this.onConfirm, this.onResend});

  @override
  State<AuthOTPModalPopupWidget> createState() => _AuthOTPModalPopupWidgetState();
}

class _AuthOTPModalPopupWidgetState extends State<AuthOTPModalPopupWidget> {
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
    _startNotifier.dispose();
    _hasResendNotifier.dispose();
    _timer?.cancel();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.hideKeyboard,
      child: SizedBox(
        height: MediaQuery.of(context).copyWith().size.height * .85,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSizings.radius),
          child: Scaffold(
              bottomSheet: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizings.paddingLg),
                child: Container(
                  alignment: Alignment.topCenter,
                  height: 50,
                  padding: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xFFEFEFEF))), color: Colors.white),
                  child: const SafeArea(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Power by ", style: TextStyle(fontSize: AppSizings.tSm)),
                      ImageViewer(AppImages.imgAuthMb, height: 22),
                    ],
                  )),
                ),
              ),
              body: ListView(
                padding: const EdgeInsets.all(20),
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  SizedBox(
                      height: 30,
                      child: Row(children: [
                        const Spacer(),
                        IconButton(onPressed: _onBack, icon: const Icon(Icons.clear)),
                      ])),
                  const Center(child: ImageViewer(AppImages.imgAuthLogo, width: AppSizings.logo)),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(widget.title ?? AppStrings.authEnterOTP.tr(),
                        style: const TextStyle(fontSize: AppSizings.t3Lg, fontWeight: FontWeight.bold, color: AppColors.subTitle)),
                  ),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(color: Color(0xff908F8C), height: 22 / AppSizings.tBase),
                        children: [
                          TextSpan(text: '${AppStrings.authTipOTPSend.tr()} '),
                          TextSpan(text: widget.email, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
                        ],
                      )),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSizings.padding),
                    child: OtpWidget(),
                  ),
                  CustomButton(
                    onPressed: widget.onConfirm,
                    title: AppStrings.authOTPConfirm.tr(),
                  ),
                  const Gap(20),
                  Text(AppStrings.authNotReceivedOTP.tr(),
                      textAlign: TextAlign.center, style: const TextStyle(fontSize: 13, color: Color(0xff908F8C), height: 22 / 13)),
                  ValueListenableBuilder<bool>(
                    valueListenable: _hasResendNotifier,
                    builder: (context, hasSend, child) => hasSend
                        ? GestureDetector(
                            onTap: _onResend,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Gửi lại mã xác thực', style: TextStyle(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.bold)),
                                  Icon(Icons.chevron_right, size: 20, color: AppColors.primary)
                                ],
                              ),
                            ),
                          )
                        : RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: const TextStyle(fontSize: 13, color: Color(0xffB2B2B2), height: 22 / 13, fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(text: AppStrings.authResendOTPLater.tr(args: [': '])),
                                WidgetSpan(
                                  child: ValueListenableBuilder<int>(
                                    valueListenable: _startNotifier,
                                    builder: (context, value, child) => Text(
                                      '$value' 's',
                                      style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  void _onResend() async {
    context.hideKeyboard();
    await widget.onResend?.call();
    _startNotifier.value = sec;
    _hasResendNotifier.value = false;
    startTimer();
  }

  void _onBack() {
    context.hideKeyboard();
    Navigator.of(context).pop();
  }
}
