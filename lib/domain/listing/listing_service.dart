import 'models/login_model.dart';

abstract class ListingService {
  Future<LoginModel> loginCheck(String mobileNo, String password);
}
