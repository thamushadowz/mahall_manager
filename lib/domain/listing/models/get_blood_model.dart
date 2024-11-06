import 'dart:convert';

/// status : "success"
/// message : "BloodData fetched successfully"
/// data : [{"user_reg_no":"KNY01","blood_group":"A+","name":"John Doe","mobile_no":"9876543210","house_name":"White House","place":"Kannur"},{"user_reg_no":"KNY02","blood_group":"B+","name":"Jane Smith","mobile_no":"8765432109","house_name":"Blue House","place":"Thalassery"},{"user_reg_no":"KNY03","blood_group":"O+","name":"Alex Brown","mobile_no":"7654321098","house_name":"Green House","place":"Payyannur"},{"user_reg_no":"KNY04","blood_group":"AB-","name":"Maria Garcia","mobile_no":"6543210987","house_name":"Red House","place":"Taliparamba"},{"user_reg_no":"KNY05","blood_group":"A-","name":"Mohammed Ali","mobile_no":"5432109876","house_name":"Yellow House","place":"Iritty"}]

GetBloodModel getBloodModelFromJson(String str) =>
    GetBloodModel.fromJson(json.decode(str));
String getBloodModelToJson(GetBloodModel data) => json.encode(data.toJson());

class GetBloodModel {
  GetBloodModel({
    String? status,
    String? message,
    List<BloodData>? data,
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
        _data?.add(BloodData.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  List<BloodData>? _data;
  GetBloodModel copyWith({
    String? status,
    String? message,
    List<BloodData>? data,
  }) =>
      GetBloodModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  String? get status => _status;
  String? get message => _message;
  List<BloodData>? get data => _data;

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
/// blood_group : "A+"
/// name : "John Doe"
/// mobile_no : "9876543210"
/// gender : "Male"
/// house_name : "White House"
/// place : "Kannur"

BloodData dataFromJson(String str) => BloodData.fromJson(json.decode(str));
String dataToJson(BloodData data) => json.encode(data.toJson());

class BloodData {
  BloodData({
    String? userRegNo,
    String? bloodGroup,
    String? name,
    String? mobileNo,
    String? gender,
    String? houseName,
    String? place,
  }) {
    _userRegNo = userRegNo;
    _bloodGroup = bloodGroup;
    _name = name;
    _mobileNo = mobileNo;
    _gender = gender;
    _houseName = houseName;
    _place = place;
  }

  BloodData.fromJson(dynamic json) {
    _userRegNo = json['user_reg_no'];
    _bloodGroup = json['blood_group'];
    _name = json['name'];
    _mobileNo = json['mobile_no'];
    _gender = json['gender'];
    _houseName = json['house_name'];
    _place = json['place'];
  }
  String? _userRegNo;
  String? _bloodGroup;
  String? _name;
  String? _mobileNo;
  String? _gender;
  String? _houseName;
  String? _place;
  BloodData copyWith({
    String? userRegNo,
    String? bloodGroup,
    String? name,
    String? mobileNo,
    String? gender,
    String? houseName,
    String? place,
  }) =>
      BloodData(
        userRegNo: userRegNo ?? _userRegNo,
        bloodGroup: bloodGroup ?? _bloodGroup,
        name: name ?? _name,
        mobileNo: mobileNo ?? _mobileNo,
        gender: gender ?? _gender,
        houseName: houseName ?? _houseName,
        place: place ?? _place,
      );
  String? get userRegNo => _userRegNo;
  String? get bloodGroup => _bloodGroup;
  String? get name => _name;
  String? get mobileNo => _mobileNo;
  String? get gender => _gender;
  String? get houseName => _houseName;
  String? get place => _place;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_reg_no'] = _userRegNo;
    map['blood_group'] = _bloodGroup;
    map['name'] = _name;
    map['mobile_no'] = _mobileNo;
    map['gender'] = _gender;
    map['house_name'] = _houseName;
    map['place'] = _place;
    return map;
  }
}
