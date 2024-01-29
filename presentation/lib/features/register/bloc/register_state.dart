import 'package:presentation/import.dart';

import '../../../common/validators/confirm_password_validate.dart';
import '../../../common/validators/email_validate.dart';
import '../../../common/validators/fullname_validate.dart';
import '../../../common/validators/password_validate.dart';

enum RegisterStatus { none, success, failure, validating }

enum StepRegister {
  none(AppStrings.authRegister, AppStrings.authEnterEmail),
  otp(AppStrings.authEnterOTP, AppStrings.authTipOTPSend),
  finnal(AppStrings.authRegister, AppStrings.authSetupUserAndPwd);

  const StepRegister(this.text, this.subText);
  final String text;
  final String subText;
}

class RegisterState extends BaseState {
  final RegisterStatus status;
  final FullNameValidateModel fullName;
  final EmailValidateModel email;
  final PasswordValidateModel password;
  final ConfirmPasswordValidateModel confirmPassword;
  final bool showPassword;
  final bool isNextComplete;
  final StepRegister step;

  RegisterState({
    this.status = RegisterStatus.none,
    this.fullName = const FullNameValidateModel.pure(),
    this.email = const EmailValidateModel.pure(),
    this.password = const PasswordValidateModel.pure(),
    this.confirmPassword = const ConfirmPasswordValidateModel.pure(),
    this.showPassword = false,
    this.isNextComplete = false,
    this.step = StepRegister.none,
  });

  RegisterState copyWith({
    RegisterStatus? status,
    FullNameValidateModel? fullName,
    EmailValidateModel? email,
    PasswordValidateModel? password,
    ConfirmPasswordValidateModel? confirmPassword,
    bool? showPassword,
    bool? isNextComplete,
    StepRegister? step,
  }) {
    return RegisterState(
      status: status ?? this.status,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      showPassword: showPassword ?? this.showPassword,
      isNextComplete: isNextComplete ?? this.isNextComplete,
      step: step ?? this.step,
    );
  }

  @override
  List<Object?> get props => [status, fullName, email, password, confirmPassword, showPassword, isNextComplete, step];
}
