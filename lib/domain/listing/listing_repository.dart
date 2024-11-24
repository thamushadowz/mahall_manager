import 'package:get/get.dart';
import 'package:mahall_manager/domain/listing/models/GetReportPdfModel.dart';
import 'package:mahall_manager/domain/listing/models/common_response.dart';
import 'package:mahall_manager/domain/listing/models/get_house_and_users_model.dart';
import 'package:mahall_manager/domain/listing/models/house_registration_model.dart';
import 'package:mahall_manager/domain/listing/models/payment_success_model.dart';

import '../../infrastructure/dal/services/api_service.dart';
import 'listing_service.dart';
import 'models/ChartDataModel.dart';
import 'models/GetDeceasedListModel.dart';
import 'models/MarriageRegistrationModel.dart';
import 'models/get_blood_model.dart';
import 'models/get_expat_model.dart';
import 'models/get_place_model.dart';
import 'models/get_promises_model.dart';
import 'models/get_reports_model.dart';
import 'models/input_models/MarriageRegistrationInputModel.dart';
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

  @override
  Future<CommonResponse> addOrEditPromises(
      String url, String authToken, params) async {
    CommonResponse commonResponse;
    print('Input : $params');
    final response = await apiService.reqst(
      url: url,
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
  Future<CommonResponse> deletePromises(
      String authToken, dynamic params) async {
    CommonResponse commonResponse;
    print('Input : $params');
    final response = await apiService.reqst(
      url: 'promise/delete',
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
  Future<GetPromisesModel> getPromises(String authToken) async {
    GetPromisesModel getPromisesModel;
    final response = await apiService.reqst(
      url: 'promise/all',
      authToken: authToken,
      method: Method.GET,
    );
    print('Response::: ${response.body}');
    try {
      getPromisesModel = GetPromisesModel.fromJson(response.body);
      return getPromisesModel;
    } catch (e) {
      print('Exception :::: $e');
      return GetPromisesModel();
    }
  }

  @override
  Future<CommonResponse> addOrEditIncomeOrExpense(
      String url, String authToken, params) async {
    CommonResponse commonResponse;
    print('Input : $params');
    final response = await apiService.reqst(
      url: url,
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
  Future<CommonResponse> deleteReport(String authToken, dynamic params) async {
    CommonResponse commonResponse;
    print('Input : $params');
    final response = await apiService.reqst(
      url: 'reports/delete',
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
  Future<GetReportsModel> getReports(String authToken) async {
    GetReportsModel getReportsModel;
    final response = await apiService.reqst(
      url: 'reports/all',
      authToken: authToken,
      method: Method.GET,
    );
    print('Response::: ${response.body}');
    try {
      getReportsModel = GetReportsModel.fromJson(response.body);
      return getReportsModel;
    } catch (e) {
      print('Exception :::: $e');
      return GetReportsModel();
    }
  }

  @override
  Future<GetBloodModel> getBloodGroups(String authToken) async {
    GetBloodModel getBloodModel;
    final response = await apiService.reqst(
      url: 'blood/all',
      authToken: authToken,
      method: Method.GET,
    );
    print('Response::: ${response.body}');
    try {
      getBloodModel = GetBloodModel.fromJson(response.body);
      return getBloodModel;
    } catch (e) {
      print('Exception :::: $e');
      return GetBloodModel();
    }
  }

  @override
  Future<GetExpatModel> getExpats(String authToken) async {
    GetExpatModel getExpatModel;
    final response = await apiService.reqst(
      url: 'expat/all',
      authToken: authToken,
      method: Method.GET,
    );
    print('Response::: ${response.body}');
    try {
      getExpatModel = GetExpatModel.fromJson(response.body);
      return getExpatModel;
    } catch (e) {
      print('Exception :::: $e');
      return GetExpatModel();
    }
  }

  @override
  Future<GetHouseAndUsersModel> getUserProfile(String authToken) async {
    GetHouseAndUsersModel getHouseAndUsersModel;
    final response = await apiService.reqst(
      url: 'user/profile',
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
  Future<GetHouseAndUsersModel> getSingleHouseAndUsers(String authToken) async {
    GetHouseAndUsersModel getHouseAndUsersModel;
    final response = await apiService.reqst(
      url: 'house/user/all',
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
  Future<CommonResponse> resetPassword(String authToken, params) async {
    CommonResponse commonResponse;
    print('Input : $params');
    final response = await apiService.reqst(
      url: 'password/reset',
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
  Future<CommonResponse> logout(String authToken) async {
    CommonResponse commonResponse;
    final response = await apiService.reqst(
      url: 'logout',
      authToken: authToken,
      method: Method.POST,
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
  Future<CommonResponse> deleteAccount(String authToken, params) async {
    CommonResponse commonResponse;
    print('Input : $params');
    final response = await apiService.reqst(
      url: 'account/delete',
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
  Future<PaymentSuccessModel> payment(String authToken, params) async {
    PaymentSuccessModel paymentSuccessModel;
    print('Input : $params');
    final response = await apiService.reqst(
      url: 'payment',
      authToken: authToken,
      method: Method.POST,
      params: params,
    );
    print('Response::: ${response.body}');
    try {
      paymentSuccessModel = PaymentSuccessModel.fromJson(response.body);
      return paymentSuccessModel;
    } catch (e) {
      return PaymentSuccessModel();
    }
  }

  @override
  Future<GetReportPdfModel> generateReportPdf(String authToken, params) async {
    GetReportPdfModel getReportPdfModel;
    print('Input : $params');
    final response = await apiService.reqst(
      url: 'reports/generate-pdf',
      authToken: authToken,
      method: Method.POST,
      params: params,
    );
    print('Response::: ${response.body}');
    try {
      getReportPdfModel = GetReportPdfModel.fromJson(response.body);
      return getReportPdfModel;
    } catch (e) {
      return GetReportPdfModel();
    }
  }

  @override
  Future<GetReportPdfModel> getReportsPdfList(String authToken) async {
    GetReportPdfModel getReportPdfModel;
    final response = await apiService.reqst(
      url: 'reports/generate-pdf/all',
      authToken: authToken,
      method: Method.GET,
    );
    print('Response::: ${response.body}');
    try {
      getReportPdfModel = GetReportPdfModel.fromJson(response.body);
      return getReportPdfModel;
    } catch (e) {
      return GetReportPdfModel();
    }
  }

  @override
  Future<CommonResponse> registerDeath(String authToken, dynamic params) async {
    CommonResponse commonResponse;
    print('Input : $params');
    final response = await apiService.reqst(
      url: 'death/add',
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
  Future<GetDeceasedListModel> getDeceasedList(String authToken) async {
    GetDeceasedListModel getDeceasedListModel;
    final response = await apiService.reqst(
      url: 'death/all',
      authToken: authToken,
      method: Method.GET,
    );
    print('Response::: ${response.body}');
    try {
      getDeceasedListModel = GetDeceasedListModel.fromJson(response.body);
      return getDeceasedListModel;
    } catch (e) {
      return GetDeceasedListModel();
    }
  }

  @override
  Future<MarriageRegistrationModel> registerMarriage(
      String authToken, MarriageRegistrationInputModel params) async {
    MarriageRegistrationModel marriageRegistrationModel;
    print('Input : $params');
    final response = await apiService.reqst(
      url: 'marriage/add',
      authToken: authToken,
      method: Method.POST,
      params: params.toJson(),
    );
    print('Response::: ${response.body}');
    try {
      marriageRegistrationModel =
          MarriageRegistrationModel.fromJson(response.body);
      return marriageRegistrationModel;
    } catch (e) {
      return MarriageRegistrationModel();
    }
  }

  @override
  Future<MarriageRegistrationModel> getMarriageCertificateList(
      String authToken) async {
    MarriageRegistrationModel marriageRegistrationModel;
    final response = await apiService.reqst(
      url: 'marriage/all',
      authToken: authToken,
      method: Method.GET,
    );
    print('Response::: ${response.body}');
    try {
      marriageRegistrationModel =
          MarriageRegistrationModel.fromJson(response.body);
      return marriageRegistrationModel;
    } catch (e) {
      return MarriageRegistrationModel();
    }
  }

  @override
  Future<ChartDataModel> getChartData(String authToken) async {
    ChartDataModel chartDataModel;
    final response = await apiService.reqst(
      url: 'chart-data',
      authToken: authToken,
      method: Method.GET,
    );
    print('Response::: ${response.body}');
    try {
      chartDataModel = ChartDataModel.fromJson(response.body);
      return chartDataModel;
    } catch (e) {
      return ChartDataModel();
    }
  }
}
