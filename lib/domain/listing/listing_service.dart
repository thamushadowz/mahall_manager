import 'package:mahall_manager/domain/listing/models/ChartDataModel.dart';
import 'package:mahall_manager/domain/listing/models/GetDeceasedListModel.dart';
import 'package:mahall_manager/domain/listing/models/GetNotificationsModel.dart';
import 'package:mahall_manager/domain/listing/models/GetReportPdfModel.dart';
import 'package:mahall_manager/domain/listing/models/MarriageRegistrationModel.dart';
import 'package:mahall_manager/domain/listing/models/common_response.dart';
import 'package:mahall_manager/domain/listing/models/get_blood_model.dart';
import 'package:mahall_manager/domain/listing/models/get_house_and_users_model.dart';
import 'package:mahall_manager/domain/listing/models/get_place_model.dart';
import 'package:mahall_manager/domain/listing/models/get_promises_model.dart';
import 'package:mahall_manager/domain/listing/models/get_reports_model.dart';
import 'package:mahall_manager/domain/listing/models/input_models/mahall_registration_input_model.dart';
import 'package:mahall_manager/domain/listing/models/mahall_registration_or_details_model.dart';

import 'models/GetMasjidListModel.dart';
import 'models/committee_details_model.dart';
import 'models/get_expat_model.dart';
import 'models/house_registration_model.dart';
import 'models/input_models/MarriageRegistrationInputModel.dart';
import 'models/login_model.dart';
import 'models/payment_success_model.dart';

abstract class ListingService {
  Future<GetMasjidListModel> getMasjidsList(dynamic query);

  Future<LoginModel> loginCheck(
      String mobileNo, String masjidId, String password, String fcmToken);

  Future<CommonResponse> mahallRegistration(
      String authToken, MahallRegistrationInputModel params);

  Future<MahallRegistrationOrDetailsModel> getMahallDetails(String authToken);

  Future<CommonResponse> updateMahallDetails(
      String authToken, MahallRegistrationInputModel params);

  Future<CommonResponse> houseRegistration(String authToken, dynamic params);

  Future<HouseRegistrationModel> getHouseDetails(String authToken);

  Future<CommonResponse> updateHouse(String authToken, dynamic params);

  Future<CommonResponse> deleteHouse(String authToken, dynamic params);

  Future<CommonResponse> placeRegistration(String authToken, dynamic params);

  Future<GetPlaceModel> getPlaceDetails(String authToken);

  Future<CommonResponse> userRegistration(String authToken, PeopleData params);

  Future<GetHouseAndUsersModel> getHouseAndUsersDetails(
      String authToken, dynamic query);

  Future<CommonResponse> updateUser(String authToken, PeopleData params);

  Future<CommonResponse> deleteUser(String authToken, dynamic params);

  Future<CommonResponse> addOrEditPromises(
      String url, String authToken, dynamic params);

  Future<CommonResponse> deletePromises(String authToken, dynamic params);

  Future<GetPromisesModel> getPromises(String authToken, dynamic query);

  Future<CommonResponse> addOrEditIncomeOrExpense(
      String url, String authToken, dynamic params);

  Future<CommonResponse> deleteReport(String authToken, dynamic params);

  Future<GetReportsModel> getReports(String authToken, dynamic query);

  Future<GetBloodModel> getBloodGroups(String authToken, dynamic query);

  Future<GetExpatModel> getExpats(String authToken, dynamic query);

  Future<GetHouseAndUsersModel> getUserProfile(String authToken);

  Future<GetHouseAndUsersModel> getSingleHouseAndUsers(String authToken);

  Future<GetPromisesModel> getSingleHousePromises(String authToken);

  Future<CommonResponse> resetPassword(String authToken, dynamic params);

  Future<CommonResponse> logout(String authToken);

  Future<CommonResponse> deleteAccount(String authToken, dynamic params);

  Future<PaymentSuccessModel> payment(String authToken, dynamic params);

  Future<GetReportPdfModel> generateReportPdf(String authToken, dynamic params);

  Future<GetReportPdfModel> getReportsPdfList(String authToken);

  Future<CommonResponse> registerDeath(String authToken, dynamic params);

  Future<GetDeceasedListModel> getDeceasedList(String authToken);

  Future<MarriageRegistrationModel> registerMarriage(
      String authToken, MarriageRegistrationInputModel params);

  Future<MarriageRegistrationModel> getMarriageCertificateList(
      String authToken);

  Future<ChartDataModel> getChartData(String authToken);

  Future<GetNotificationsModel> getNotifications(String authToken);

  Future<CommonResponse> updateNotification(String authToken, dynamic params);

  Future<CommonResponse> sendNotification(String authToken, dynamic params);

  Future<CommonResponse> updateVarisankhya(String authToken, dynamic params);

  Future<CommitteeDetailsModel> getCommitteeDetails(String authToken);

  Future<CommonResponse> addCommitteeDetails(String authToken, dynamic params);

  Future<CommonResponse> updateCommitteeDetails(
      String authToken, dynamic params);

  Future<CommonResponse> deleteCommitteeDetails(
      String authToken, dynamic params);
}
