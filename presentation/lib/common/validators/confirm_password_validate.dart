import 'package:core/common/helper/helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:formz/formz.dart';
import 'package:presentation/import.dart';

class ConfirmPasswordValidateModel extends FormzInput<String, String?> {
  final String password;

  const ConfirmPasswordValidateModel.pure({this.password = ''}) : super.pure('');
  const ConfirmPasswordValidateModel.dirty({required this.password, String value = ''}) : super.dirty(value);

  static final _passwordRegExp = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).{6,}$');

  @override
  String? validator(String value) {
    if (empty(value.trim())) return AppStrings.validatorEmptyPassword.tr();
    if (!_passwordRegExp.hasMatch(value.trim())) return AppStrings.validatorInvalidPassword.tr();
    return (password == value ? null : AppStrings.validatorMismatchPassword.tr());
  }
}
