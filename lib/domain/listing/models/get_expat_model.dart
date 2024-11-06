import 'dart:convert';

/// status : "success"
/// message : "Data fetched successfully"
/// data : [{"user_reg_no":"KNY01","country":"UAE","name":"John Doe","mobile_no":"9876543210","house_name":"White House","place":"Kannur"},{"user_reg_no":"KNY02","country":"Saudi Arabia","name":"Jane Smith","mobile_no":"8765432109","house_name":"Blue House","place":"Thalassery"},{"user_reg_no":"KNY03","country":"Saudi Arabia","name":"Alex Brown","mobile_no":"7654321098","house_name":"Green House","place":"Payyannur"},{"user_reg_no":"KNY04","country":"Saudi Arabia","name":"Maria Garcia","mobile_no":"6543210987","house_name":"Red House","place":"Taliparamba"},{"user_reg_no":"KNY05","country":"Saudi Arabia","name":"Mohammed Ali","mobile_no":"5432109876","house_name":"Yellow House","place":"Iritty"}]

GetBloodModel getBloodModelFromJson(String str) =>
    GetBloodModel.fromJson(json.decode(str));
String getBloodModelToJson(GetBloodModel data) => json.encode(data.toJson());

class GetBloodModel {
  GetBloodModel({
    String? status,
    String? message,
    List<ExpatData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetBloodModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ExpatData.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  List<ExpatData>? _data;
  GetBloodModel copyWith({
    String? status,
    String? message,
    List<ExpatData>? data,
  }) =>
      GetBloodModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  String? get status => _status;
  String? get message => _message;
  List<ExpatData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// user_reg_no : "KNY01"
/// country : "Saudi Arabia"
/// name : "John Doe"
/// mobile_no : "9876543210"
/// gender : "Male"
/// house_name : "White House"
/// place : "Kannur"

ExpatData dataFromJson(String str) => ExpatData.fromJson(json.decode(str));
String dataToJson(ExpatData data) => json.encode(data.toJson());

class ExpatData {
  ExpatData({
    String? userRegNo,
    String? country,
    String? name,
    String? mobileNo,
    String? houseName,
    String? place,
  }) {
    _userRegNo = userRegNo;
    _country = country;
    _name = name;
    _mobileNo = mobileNo;
    _houseName = houseName;
    _place = place;
  }

  ExpatData.fromJson(dynamic json) {
    _userRegNo = json['user_reg_no'];
    _country = json['country'];
    _name = json['name'];
    _mobileNo = json['mobile_no'];
    _houseName = json['house_name'];
    _place = json['place'];
  }
  String? _userRegNo;
  String? _country;
  String? _name;
  String? _mobileNo;
  String? _houseName;
  String? _place;
  ExpatData copyWith({
    String? userRegNo,
    String? country,
    String? name,
    String? mobileNo,
    String? houseName,
    String? place,
  }) =>
      ExpatData(
        userRegNo: userRegNo ?? _userRegNo,
        country: country ?? _country,
        name: name ?? _name,
        mobileNo: mobileNo ?? _mobileNo,
        houseName: houseName ?? _houseName,
        place: place ?? _place,
      );
  String? get userRegNo => _userRegNo;
  String? get country => _country;
  String? get name => _name;
  String? get mobileNo => _mobileNo;
  String? get houseName => _houseName;
  String? get place => _place;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_reg_no'] = _userRegNo;
    map['country'] = _country;
    map['name'] = _name;
    map['mobile_no'] = _mobileNo;
    map['house_name'] = _houseName;
    map['place'] = _place;
    return map;
  }
}
