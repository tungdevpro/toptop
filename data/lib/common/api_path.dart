abstract class ApiPath {
  const ApiPath._();
  static const String config = '/common/config';

  static const String account = '/account';
  static const String loginSoical = '$account/soical/login';
  static const String loginEmail = '$account/email/login';

  static const String requestOTP = '$account/email/request-otp';
  static const String resendOTP = '$account/email/resend-otp';
  static const String verifyOTP = '$account/email/verify-otp';
  static const String registerSocial = '$account/social/register';
  static const String registerEmail = '$account/email/register';
}
