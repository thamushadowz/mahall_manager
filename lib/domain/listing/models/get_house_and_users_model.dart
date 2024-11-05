import 'dart:convert';

/// status : true
/// message : "success"
/// data : [{"house_reg_no":"KNY01","house_name":"White House","people":[{"user_reg_no":"U01","name":"Person 1","phone":"1234567890","due":"₹1000"},{"user_reg_no":"U02","name":"Person 2","phone":"1234567891","due":"₹2000"}]},{"house_reg_no":"KNY02","house_name":"New House","people":[{"user_reg_no":"U03","name":"Person 1","phone":"1234567890","due":"₹1000"},{"user_reg_no":"U04","name":"Person 2","phone":"1234567891","due":"₹2000"},{"user_reg_no":"U05","name":"Person 3","phone":"1234567891","due":"₹2000"}]}]

GetHouseAndUsersModel getHouseAndUsersModelFromJson(String str) =>
    GetHouseAndUsersModel.fromJson(json.decode(str));
String getHouseAndUsersModelToJson(GetHouseAndUsersModel data) =>
    json.encode(data.toJson());

class GetHouseAndUsersModel {
  GetHouseAndUsersModel({
    bool? status,
    String? message,
    List<HouseData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetHouseAndUsersModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(HouseData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<HouseData>? _data;
  GetHouseAndUsersModel copyWith({
    bool? status,
    String? message,
    List<HouseData>? data,
  }) =>
      GetHouseAndUsersModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<HouseData>? get data => _data;

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

/// house_reg_no : "KNY01"
/// house_name : "White House"
/// people : [{"user_reg_no":"U01","name":"Person 1","phone":"1234567890","due":"₹1000"},{"user_reg_no":"U02","name":"Person 2","phone":"1234567891","due":"₹2000"}]

HouseData dataFromJson(String str) => HouseData.fromJson(json.decode(str));
String dataToJson(HouseData data) => json.encode(data.toJson());

class HouseData {
  HouseData({
    String? houseRegNo,
    String? houseName,
    List<People>? people,
  }) {
    _houseRegNo = houseRegNo;
    _houseName = houseName;
    _people = people;
  }

  HouseData.fromJson(dynamic json) {
    _houseRegNo = json['house_reg_no'];
    _houseName = json['house_name'];
    if (json['people'] != null) {
      _people = [];
      json['people'].forEach((v) {
        _people?.add(People.fromJson(v));
      });
    }
  }
  String? _houseRegNo;
  String? _houseName;
  List<People>? _people;
  HouseData copyWith({
    String? houseRegNo,
    String? houseName,
    List<People>? people,
  }) =>
      HouseData(
        houseRegNo: houseRegNo ?? _houseRegNo,
        houseName: houseName ?? _houseName,
        people: people ?? _people,
      );
  String? get houseRegNo => _houseRegNo;
  String? get houseName => _houseName;
  List<People>? get people => _people;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['house_reg_no'] = _houseRegNo;
    map['house_name'] = _houseName;
    if (_people != null) {
      map['people'] = _people?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// user_reg_no:"U01"
/// name : "Person 1"
/// phone : "1234567890"
/// due : "₹1000"

People peopleFromJson(String str) => People.fromJson(json.decode(str));
String peopleToJson(People data) => json.encode(data.toJson());

class People {
  People({
    String? userRegNo,
    String? name,
    String? phone,
    String? due,
  }) {
    _userRegNo = userRegNo;
    _name = name;
    _phone = phone;
    _due = due;
  }

  People.fromJson(dynamic json) {
    _userRegNo = json['user_reg_no'];
    _name = json['name'];
    _phone = json['phone'];
    _due = json['due'];
  }
  String? _userRegNo;
  String? _name;
  String? _phone;
  String? _due;
  People copyWith({
    String? userRegNo,
    String? name,
    String? phone,
    String? due,
  }) =>
      People(
        userRegNo: userRegNo ?? _userRegNo,
        name: name ?? _name,
        phone: phone ?? _phone,
        due: due ?? _due,
      );
  String? get userRegNo => _userRegNo;
  String? get name => _name;
  String? get phone => _phone;
  String? get due => _due;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_reg_no'] = _userRegNo;
    map['name'] = _name;
    map['phone'] = _phone;
    map['due'] = _due;
    return map;
  }
}
