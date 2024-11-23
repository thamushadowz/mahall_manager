import 'dart:convert';

/// status : "success"
/// message : "Data fetched successfully"
/// data : [{"user_reg_no":"KNY01","country":"UAE","name":"John Doe","mobile_no":"9876543210","house_name":"White House","place":"Kannur"},{"user_reg_no":"KNY02","country":"Saudi Arabia","name":"Jane Smith","mobile_no":"8765432109","house_name":"Blue House","place":"Thalassery"},{"user_reg_no":"KNY03","country":"Saudi Arabia","name":"Alex Brown","mobile_no":"7654321098","house_name":"Green House","place":"Payyannur"},{"user_reg_no":"KNY04","country":"Saudi Arabia","name":"Maria Garcia","mobile_no":"6543210987","house_name":"Red House","place":"Taliparamba"},{"user_reg_no":"KNY05","country":"Saudi Arabia","name":"Mohammed Ali","mobile_no":"5432109876","house_name":"Yellow House","place":"Iritty"}]

GetExpatModel getExpatModelFromJson(String str) =>
    GetExpatModel.fromJson(json.decode(str));

String getExpatModelToJson(GetExpatModel data) => json.encode(data.toJson());

class GetExpatModel {
  GetExpatModel({
    bool? status,
    String? message,
    List<ExpatData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetExpatModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ExpatData.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  List<ExpatData>? _data;

  GetExpatModel copyWith({
    bool? status,
    String? message,
    List<ExpatData>? data,
  }) =>
      GetExpatModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

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
    String? fName,
    String? lName,
    String? mobileNo,
    String? houseName,
    String? place,
  }) {
    _userRegNo = userRegNo;
    _country = country;
    _fName = fName;
    _lName = lName;
    _mobileNo = mobileNo;
    _houseName = houseName;
    _place = place;
  }

  ExpatData.fromJson(dynamic json) {
    _userRegNo = json['user_reg_no'];
    _country = json['country'];
    _fName = json['f_name'];
    _lName = json['l_name'];
    _mobileNo = json['phone'];
    _houseName = json['house_name'];
    _place = json['place'];
  }

  String? _userRegNo;
  String? _country;
  String? _fName;
  String? _lName;
  String? _mobileNo;
  String? _houseName;
  String? _place;

  ExpatData copyWith({
    String? userRegNo,
    String? country,
    String? fName,
    String? lName,
    String? mobileNo,
    String? houseName,
    String? place,
  }) =>
      ExpatData(
        userRegNo: userRegNo ?? _userRegNo,
        country: country ?? _country,
        fName: fName ?? _fName,
        lName: lName ?? _lName,
        mobileNo: mobileNo ?? _mobileNo,
        houseName: houseName ?? _houseName,
        place: place ?? _place,
      );

  String? get userRegNo => _userRegNo;

  String? get country => _country;

  String? get fName => _fName;

  String? get lName => _lName;

  String? get mobileNo => _mobileNo;

  String? get houseName => _houseName;

  String? get place => _place;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_reg_no'] = _userRegNo;
    map['country'] = _country;
    map['f_name'] = _fName;
    map['l_name'] = _lName;
    map['phone'] = _mobileNo;
    map['house_name'] = _houseName;
    map['place'] = _place;
    return map;
  }
}
