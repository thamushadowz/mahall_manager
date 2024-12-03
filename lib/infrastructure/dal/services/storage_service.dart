import 'package:get_storage/get_storage.dart';

class StorageService {
  final GetStorage _storage = GetStorage();

  final String _tokenKey = 'auth_token';
  final String _userTypeKey = 'user_type';
  final String _languageKey = 'preferred_language';
  final String _mahallNameKey = 'mahall_name';
  final String _lastNotificationKey = 'last-notification';

  void saveToken(String token) {
    _storage.write(_tokenKey, token);
  }

  void saveUserType(String userType) {
    _storage.write(_userTypeKey, userType);
  }

  void savePreferredLanguage(String preferredLanguage) {
    _storage.write(_languageKey, preferredLanguage);
  }

  void saveMahallName(String mahallName) {
    _storage.write(_mahallNameKey, mahallName);
  }

  void saveLastNotification(String notification) {
    _storage.write(_lastNotificationKey, notification);
  }

  String? getToken() => _storage.read(_tokenKey);

  String? getUserType() => _storage.read(_userTypeKey);

  String? getPreferredLanguage() => _storage.read(_languageKey);

  String? getMahallName() => _storage.read(_mahallNameKey);

  String? getLastNotification() => _storage.read(_lastNotificationKey);

  bool isLoggedIn() => getToken() != null;

  void logout() {
    _storage.erase();
  }
}
