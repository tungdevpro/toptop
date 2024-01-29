import 'dart:async';

import 'package:core/service/snackbar_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:presentation/common/validators/email_validate.dart';
import 'package:presentation/common/validators/password_validate.dart';
import 'package:presentation/features/register/bloc/register_event.dart';
import 'package:presentation/features/register/bloc/register_state.dart';
import 'package:presentation/import.dart';

import '../../../common/validators/confirm_password_validate.dart';

@injectable
class RegisterBloc extends BaseBloc<RegisterEvent, RegisterState> implements LibraryInitializer {
  RegisterBloc() : super(RegisterState(status: RegisterStatus.failure));

  static RegisterBloc get to => locator<RegisterBloc>()..init();

  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  Future<void> init() async {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void listEvent() {
    on<RegisterEmailChangedEvent>(_onRegisterEmailChangedEvent);
    on<RegisterNextStepCompleteEvent>(_onRegisterNextStepCompleteEvent);
    on<RegisterChangeStepEvent>(_onRegisterChangeStepEvent);
    on<RegisterPasswordChangedEvent>(_onRegisterPasswordChangedEvent);
    on<RegisterConfirmPasswordChangedEvent>(_onRegisterConfirmPasswordChangedEvent);
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }

  void _onRegisterEmailChangedEvent(RegisterEmailChangedEvent event, Emitter<RegisterState> emit) {
    final emailModel = EmailValidateModel.dirty(event.email);
    emit(state.copyWith(status: RegisterStatus.validating, email: emailModel));
  }

  void _onRegisterNextStepCompleteEvent(RegisterNextStepCompleteEvent event, Emitter<RegisterState> emit) async {
    // final _ = await showModalBottomSheet(
    //   context: context,
    //   isScrollControlled: true,
    //   shape: const RoundedRectangleBorder(
    //       borderRadius: BorderRadius.only(topLeft: Radius.circular(AppSizings.radius), topRight: Radius.circular(AppSizings.radius))),
    //   isDismissible: false,
    //   builder: (BuildContext context) => AuthOTPModalPopupWidget(
    //     email: state.email.value,
    //     onConfirm: () {
    //       locator<SnackbarService>().show(context, 'Has an error', status: SnackbarStatus.failure);
    //     },
    //     onResend: () async {
    //       showLoading();
    //       await Future.delayed(const Duration(seconds: 4));
    //       hideLoading();
    //     },
    //   ),
    // );
  }

  void _onRegisterChangeStepEvent(RegisterChangeStepEvent event, Emitter<RegisterState> emit) {
    if (!state.email.isValid) {
      locator<SnackbarService>().show(
        context,
        state.email.displayError ?? AppStrings.validatorInvalidEmail.tr(),
        status: SnackbarStatus.failure,
      );
      return;
    }

    emit(state.copyWith(step: event.step));
  }

  void _onRegisterPasswordChangedEvent(RegisterPasswordChangedEvent event, Emitter<RegisterState> emit) {
    final passwordModel = PasswordValidateModel.dirty(event.password);
    emit(state.copyWith(status: RegisterStatus.validating, password: passwordModel));
  }

  void _onRegisterConfirmPasswordChangedEvent(RegisterConfirmPasswordChangedEvent event, Emitter<RegisterState> emit) {
    final confirmPasswordModel = ConfirmPasswordValidateModel.dirty(password: state.password.value, value: event.confirmPassword);
    emit(state.copyWith(status: RegisterStatus.validating, confirmPassword: confirmPasswordModel));
  }
}
