import 'package:domain/common/result.dart';
import 'package:domain/model/request_otp_model.dart';

import '../../model/otp_request_id_model.dart';
import 'get_request_otp_use_case.dart';

class GetRequestOTPUseCaseImpl extends GetRequestOTPUseCase {
  @override
  Future<Result<OTPRequestIdModel>> getOTP(RequestOTPModel model) {
    throw UnimplementedError();
  }
}
