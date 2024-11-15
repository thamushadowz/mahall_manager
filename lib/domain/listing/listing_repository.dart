import 'package:get/get.dart';
import 'package:mahall_manager/domain/listing/models/common_response.dart';
import 'package:mahall_manager/domain/listing/models/mahall_registration_input_model.dart';

import '../../infrastructure/dal/services/api_service.dart';
import 'listing_service.dart';
import 'models/login_model.dart';

class ListingRepository implements ListingService {
  ApiService apiService = Get.find();

  @override
  Future<LoginModel> loginCheck(String mobileNo, String password) async {
    LoginModel loginModel;
    final response = await apiService.reqst(
        url: 'login',
        method: Method.POST,
        params: {
          "phone": mobileNo.toString(),
          "password": password.toString()
        });
    try {
      loginModel = LoginModel.fromJson(response.body);
      return loginModel;
    } catch (e) {
      return LoginModel();
    }
  }

  @override
  Future<CommonResponse> mahallRegistration(
      String authToken, MahallRegistrationInputModel params) async {
    CommonResponse commonResponse;
    final response = await apiService.reqst(
      url: 'create-masjid',
      authToken: authToken,
      method: Method.POST,
      params: params.toJson(),
    );
    print('Response::: ${response.body}');
    try {
      commonResponse = CommonResponse.fromJson(response.body);
      return commonResponse;
    } catch (e) {
      return CommonResponse();
    }
  }
}
