import 'package:easy_localization/easy_localization.dart';
import 'package:presentation/features/register/bloc/register_bloc.dart';
import 'package:presentation/features/register/bloc/register_state.dart';
import 'package:presentation/import.dart';
import 'package:presentation/shared/auth/auth_background_widget.dart';
import 'package:presentation/shared/auth/otp_widget.dart';

import '../../common/widgets/custom_button.dart';
import '../../common/widgets/custom_text_field.dart';
import 'bloc/register_event.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends CoreViewState<RegisterPage, RegisterBloc> {
  @override
  RegisterBloc get initBloc => RegisterBloc.to;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {},
        child: BlocSelector<RegisterBloc, RegisterState, StepRegister>(
          selector: (state) => state.step,
          builder: (context, step) => AuthBackgroundWidget(
            title: step.text.tr(),
            subTitle: step == StepRegister.otp ? _buildSubTitleOTP() : step.subText.tr(),
            hasBack: step != StepRegister.none,
            onBack: () => _onHandleBack(step),
            children: [
              if (step == StepRegister.none) _buildEmail(),
              if (step == StepRegister.otp) const OtpWidget(),
              if (step == StepRegister.finnal) _buildPassword(),
              const SizedBox(height: 56),
              _buildButtonConfirm(step),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmail() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return CustomTextField(
          labelText: AppStrings.authEmail.tr(),
          controller: bloc.emailController,
          errorText: state.email.displayError,
          onChanged: (val) => bloc.add(RegisterEmailChangedEvent(val ?? '')),
          hintText: AppStrings.authEnterEmail.tr(),
        );
      },
    );
  }

  Widget _buildPassword() {
    return Column(
      children: [
        BlocBuilder<RegisterBloc, RegisterState>(
          buildWhen: (previous, current) => previous.password != current.password,
          builder: (context, state) {
            return CustomTextField(
              key: const ValueKey('password_key'),
              errorText: state.password.displayError,
              labelText: AppStrings.authPassword.tr(),
              controller: bloc.passwordController,
              obscureText: true,
              onChanged: (val) => bloc.add(RegisterPasswordChangedEvent(val ?? '')),
              hintText: AppStrings.authEnterPassword.tr(),
            );
          },
        ),
        const SizedBox(height: 8),
        BlocBuilder<RegisterBloc, RegisterState>(
            buildWhen: (previous, current) => previous.confirmPassword != current.confirmPassword,
            builder: (context, state) {
              return CustomTextField(
                key: const ValueKey('confirm_password_key'),
                errorText: state.confirmPassword.displayError,
                labelText: AppStrings.authConfirmPassword.tr(),
                controller: bloc.confirmPasswordController,
                obscureText: true,
                onChanged: (val) => bloc.add(RegisterConfirmPasswordChangedEvent(val ?? '')),
                hintText: AppStrings.authEnterPassword.tr(),
              );
            }),
      ],
    );
  }

  Widget _buildButtonConfirm(StepRegister input) {
    return CustomButton(
      onPressed: () {
        StepRegister s;
        switch (input) {
          case StepRegister.otp:
            s = StepRegister.finnal;
          case StepRegister.none:
            s = StepRegister.otp;
          default:
            s = StepRegister.none;
        }
        bloc.add(RegisterChangeStepEvent(s));
      },
      title: input == StepRegister.finnal ? AppStrings.baseConfirm.tr() : AppStrings.baseContinue.tr(),
    );
  }

  void _onHandleBack(StepRegister step) =>
      bloc.add(RegisterChangeStepEvent(step == StepRegister.otp ? StepRegister.none : (step == StepRegister.finnal ? StepRegister.otp : StepRegister.none)));

  Widget _buildSubTitleOTP() {
    return RichText(
        text: TextSpan(style: const TextStyle(color: AppColors.subTitle2, fontWeight: FontWeight.w500), children: [
      TextSpan(text: '${AppStrings.authTipOTPSend.tr()} '),
      WidgetSpan(
          child: BlocBuilder<RegisterBloc, RegisterState>(
              buildWhen: (previous, current) => previous.email != current.email,
              builder: (context, state) {
                return Text(state.email.value, style: const TextStyle(fontWeight: FontWeight.w500, color: AppColors.primary2));
              })),
    ]));
  }
}
