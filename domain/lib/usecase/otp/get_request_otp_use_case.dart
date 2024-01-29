import 'package:domain/common/result.dart';
import 'package:domain/model/request_otp_model.dart';

import '../../model/otp_request_id_model.dart';

abstract class GetRequestOTPUseCase {
  Future<Result<OTPRequestIdModel>> getOTP(RequestOTPModel model);
}
