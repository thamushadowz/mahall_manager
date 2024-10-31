import 'dart:convert';

/// status : true
/// message : "Login Successful"
/// token : "asdfghjk"
/// userType : 0

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));
String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    bool? status,
    String? message,
    String? token,
    num? userType,
  }) {
    _status = status;
    _message = message;
    _token = token;
    _userType = userType;
  }

  LoginModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _token = json['token'];
    _userType = json['userType'];
  }
  bool? _status;
  String? _message;
  String? _token;
  num? _userType;
  LoginModel copyWith({
    bool? status,
    String? message,
    String? token,
    num? userType,
  }) =>
      LoginModel(
        status: status ?? _status,
        message: message ?? _message,
        token: token ?? _token,
        userType: userType ?? _userType,
      );
  bool? get status => _status;
  String? get message => _message;
  String? get token => _token;
  num? get userType => _userType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['token'] = _token;
    map['userType'] = _userType;
    return map;
  }
}
