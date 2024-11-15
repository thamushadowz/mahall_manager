import 'package:mahall_manager/domain/listing/models/common_response.dart';
import 'package:mahall_manager/domain/listing/models/mahall_registration_input_model.dart';

import 'models/login_model.dart';

abstract class ListingService {
  Future<LoginModel> loginCheck(String mobileNo, String password);
  Future<CommonResponse> mahallRegistration(
      String authToken, MahallRegistrationInputModel params);
}
