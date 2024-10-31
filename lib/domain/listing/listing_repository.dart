import 'package:get/get.dart';

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
}
