import 'package:core/common/helper/helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:formz/formz.dart';
import 'package:presentation/import.dart';

// enum PasswordValidationError { empty, invalid }

class PasswordValidateModel extends FormzInput<String, String?> {
  const PasswordValidateModel.pure() : super.pure('');
  const PasswordValidateModel.dirty([super.value = '']) : super.dirty();

  static final _passwordRegExp = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).{6,}$');

  @override
  String? validator(String value) {
    if (empty(value.trim())) return AppStrings.validatorEmptyPassword.tr();
    if (!_passwordRegExp.hasMatch(value.trim())) return AppStrings.validatorInvalidPassword.tr();

    return null;
  }
}
