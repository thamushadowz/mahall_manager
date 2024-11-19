import 'package:get/get.dart';
import 'package:mahall_manager/domain/listing/models/common_response.dart';
import 'package:mahall_manager/domain/listing/models/get_house_and_users_model.dart';
import 'package:mahall_manager/domain/listing/models/house_registration_model.dart';

import '../../infrastructure/dal/services/api_service.dart';
import 'listing_service.dart';
import 'models/get_place_model.dart';
import 'models/input_models/mahall_registration_input_model.dart';
import 'models/login_model.dart';
import 'models/mahall_registration_or_details_model.dart';

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

  @override
  Future<MahallRegistrationOrDetailsModel> getMahallDetails(
      String authToken) async {
    MahallRegistrationOrDetailsModel mahallRegistrationInputModel;
    final response = await apiService.reqst(
      url: 'masjid',
      authToken: authToken,
      method: Method.GET,
    );
    print('Response::: ${response.body}');
    print('AuthToken ::: $authToken');
    try {
      mahallRegistrationInputModel =
          MahallRegistrationOrDetailsModel.fromJson(response.body);
      return mahallRegistrationInputModel;
    } catch (e) {
      return MahallRegistrationOrDetailsModel();
    }
  }

  @override
  Future<CommonResponse> updateMahallDetails(
      String authToken, MahallRegistrationInputModel params) async {
    CommonResponse commonResponse;
    final response = await apiService.reqst(
      url: 'update-masjid',
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

  @override
  Future<CommonResponse> houseRegistration(
      String authToken, dynamic params) async {
    CommonResponse commonResponse;
    final response = await apiService.reqst(
      url: 'house/create',
      authToken: authToken,
      method: Method.POST,
      params: params,
    );
    print('Response::: ${response.body}');
    try {
      commonResponse = CommonResponse.fromJson(response.body);
      return commonResponse;
    } catch (e) {
      return CommonResponse();
    }
  }

  @override
  Future<HouseRegistrationModel> getHouseDetails(String authToken) async {
    HouseRegistrationModel houseRegistrationModel;
    final response = await apiService.reqst(
      url: 'house/all',
      authToken: authToken,
      method: Method.GET,
    );
    print('Response::: ${response.body}');
    print('AuthToken ::: $authToken');
    try {
      houseRegistrationModel = HouseRegistrationModel.fromJson(response.body);
      return houseRegistrationModel;
    } catch (e) {
      return HouseRegistrationModel();
    }
  }

  @override
  Future<CommonResponse> updateHouse(String authToken, params) async {
    CommonResponse commonResponse;
    final response = await apiService.reqst(
      url: 'house/update',
      authToken: authToken,
      method: Method.POST,
      params: params,
    );
    print('Response::: ${response.body}');
    try {
      commonResponse = CommonResponse.fromJson(response.body);
      return commonResponse;
    } catch (e) {
      return CommonResponse();
    }
  }

  @override
  Future<CommonResponse> deleteHouse(String authToken, params) async {
    CommonResponse commonResponse;
    final response = await apiService.reqst(
      url: 'house/delete',
      authToken: authToken,
      method: Method.POST,
      params: params,
    );
    print('Response::: ${response.body}');
    try {
      commonResponse = CommonResponse.fromJson(response.body);
      return commonResponse;
    } catch (e) {
      return CommonResponse();
    }
  }

  @override
  Future<CommonResponse> placeRegistration(String authToken, params) async {
    CommonResponse commonResponse;
    final response = await apiService.reqst(
      url: 'place/create',
      authToken: authToken,
      method: Method.POST,
      params: params,
    );
    print('Response::: ${response.body}');
    try {
      commonResponse = CommonResponse.fromJson(response.body);
      return commonResponse;
    } catch (e) {
      return CommonResponse();
    }
  }

  @override
  Future<GetPlaceModel> getPlaceDetails(String authToken) async {
    GetPlaceModel placeModel;
    final response = await apiService.reqst(
      url: 'place/all',
      authToken: authToken,
      method: Method.GET,
    );
    print('Response::: ${response.body}');
    print('AuthToken ::: $authToken');
    try {
      placeModel = GetPlaceModel.fromJson(response.body);
      return placeModel;
    } catch (e) {
      return GetPlaceModel();
    }
  }

  @override
  Future<CommonResponse> userRegistration(
      String authToken, PeopleData params) async {
    CommonResponse commonResponse;
    print('params :: $params');
    final response = await apiService.reqst(
      url: 'user/create',
      authToken: authToken,
      method: Method.POST,
      params: params.toJson(),
    );
    print('Response::: ${response.body}');
    try {
      commonResponse = CommonResponse.fromJson(response.body);
      return commonResponse;
    } catch (e) {
      print('Exception : $e');
      return CommonResponse();
    }
  }

  @override
  Future<GetHouseAndUsersModel> getHouseAndUsersDetails(
      String authToken) async {
    GetHouseAndUsersModel getHouseAndUsersModel;
    final response = await apiService.reqst(
      url: 'user/all',
      authToken: authToken,
      method: Method.GET,
    );
    print('Response::: ${response.body}');
    try {
      getHouseAndUsersModel = GetHouseAndUsersModel.fromJson(response.body);
      return getHouseAndUsersModel;
    } catch (e) {
      print('Exception :::: $e');
      return GetHouseAndUsersModel();
    }
  }

  @override
  Future<CommonResponse> updateUser(String authToken, PeopleData params) async {
    CommonResponse commonResponse;
    final response = await apiService.reqst(
      url: 'user/update',
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

  @override
  Future<CommonResponse> deleteUser(String authToken, params) async {
    CommonResponse commonResponse;
    final response = await apiService.reqst(
      url: 'user/delete',
      authToken: authToken,
      method: Method.POST,
      params: params,
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
