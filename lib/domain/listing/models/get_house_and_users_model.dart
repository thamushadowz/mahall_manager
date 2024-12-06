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
    List<PeopleData>? data,
    int? notificationCount,
  }) {
    _status = status;
    _message = message;
    _data = data;
    _notificationCount = notificationCount;
  }

  GetHouseAndUsersModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(PeopleData.fromJson(v));
      });
    }
    _notificationCount = json['notification_count'];
  }

  bool? _status;
  String? _message;
  List<PeopleData>? _data;
  int? _notificationCount;

  GetHouseAndUsersModel copyWith({
    bool? status,
    String? message,
    List<PeopleData>? data,
    int? notificationCount,
  }) =>
      GetHouseAndUsersModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
        notificationCount: notificationCount ?? _notificationCount,
      );

  bool? get status => _status;

  String? get message => _message;

  List<PeopleData>? get data => _data;

  int? get notificationCount => _notificationCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['notification_count'] = _notificationCount;
    return map;
  }
}

/// user_reg_no:"U01"
/// name : "Person 1"
/// phone : "1234567890"
/// due : "₹1000"

PeopleData peopleFromJson(String str) => PeopleData.fromJson(json.decode(str));

String peopleToJson(PeopleData data) => json.encode(data.toJson());

class PeopleData {
  PeopleData({
    num? id,
    String? userRegNo,
    String? fName,
    String? lName,
    num? houseId,
    String? houseName,
    String? houseRegNo,
    String? phone,
    String? due,
    String? totalDue,
    String? place,
    String? state,
    String? district,
    String? gender,
    String? dob,
    String? age,
    String? job,
    String? annualIncome,
    bool? willingToDonateBlood,
    String? bloodGroup,
    bool? isExpat,
    String? country,
  }) {
    _id = id;
    _userRegNo = userRegNo;
    _fName = fName;
    _lName = lName;
    _houseId = houseId;
    _houseName = houseName;
    _houseRegNo = houseRegNo;
    _phone = phone;
    _due = due;
    _totalDue = totalDue;
    _place = place;
    _state = state;
    _district = district;
    _gender = gender;
    _dob = dob;
    _age = age;
    _job = job;
    _annualIncome = annualIncome;
    _willingToDonateBlood = willingToDonateBlood;
    _bloodGroup = bloodGroup;
    _isExpat = isExpat;
    _country = country;
  }

  PeopleData.fromJson(dynamic json) {
    _id = json['id'];
    _userRegNo = json['user_reg_no'];
    _fName = json['f_name'];
    _lName = json['l_name'];
    _houseId = json['house_id'];
    _houseName = json['house_name'];
    _houseRegNo = json['house_reg_no'];
    _phone = json['phone'];
    _due = json['due'];
    _totalDue = json['total_due'];
    _place = json['place'];
    _state = json['state'];
    _district = json['district'];
    _gender = json['gender'];
    _dob = json['dob'];
    _age = json['age'];
    _job = json['job'];
    _annualIncome = json['annual_income'];
    _willingToDonateBlood = json['willing_to_donate_blood'];
    _bloodGroup = json['blood_group'];
    _isExpat = json['is_expat'];
    _country = json['country'];
  }

  num? _id;
  String? _userRegNo;
  String? _fName;
  String? _lName;
  num? _houseId;
  String? _houseName;
  String? _houseRegNo;
  String? _phone;
  String? _due;
  String? _totalDue;
  String? _place;
  String? _state;
  String? _district;
  String? _gender;
  String? _dob;
  String? _age;
  String? _job;
  String? _annualIncome;
  bool? _willingToDonateBlood;
  String? _bloodGroup;
  bool? _isExpat;
  String? _country;

  PeopleData copyWith({
    num? id,
    String? userRegNo,
    String? fName,
    String? lName,
    num? houseId,
    String? houseName,
    String? houseRegNo,
    String? phone,
    String? due,
    String? totalDue,
    String? place,
    String? state,
    String? district,
    String? gender,
    String? dob,
    String? age,
    String? job,
    String? annualIncome,
    bool? willingToDonateBlood,
    String? bloodGroup,
    bool? isExpat,
    String? country,
  }) =>
      PeopleData(
        id: id ?? _id,
        userRegNo: userRegNo ?? _userRegNo,
        fName: fName ?? _fName,
        lName: lName ?? _lName,
        houseId: houseId ?? _houseId,
        houseName: houseName ?? _houseName,
        houseRegNo: houseRegNo ?? _houseRegNo,
        phone: phone ?? _phone,
        due: due ?? _due,
        totalDue: totalDue ?? _totalDue,
        place: place ?? _place,
        state: state ?? _state,
        district: district ?? _district,
        gender: gender ?? _gender,
        dob: dob ?? _dob,
        age: age ?? _age,
        job: job ?? _job,
        annualIncome: annualIncome ?? _annualIncome,
        willingToDonateBlood: willingToDonateBlood ?? _willingToDonateBlood,
        bloodGroup: bloodGroup ?? _bloodGroup,
        isExpat: isExpat ?? _isExpat,
        country: country ?? _country,
      );

  num? get id => _id;

  String? get userRegNo => _userRegNo;

  String? get fName => _fName;

  String? get lName => _lName;

  num? get houseId => _houseId;

  String? get houseName => _houseName;

  String? get houseRegNo => _houseRegNo;

  String? get phone => _phone;

  String? get due => _due;

  String? get totalDue => _totalDue;

  String? get place => _place;

  String? get state => _state;

  String? get district => _district;

  String? get gender => _gender;

  String? get dob => _dob;

  String? get age => _age;

  String? get job => _job;

  String? get annualIncome => _annualIncome;

  bool? get willingToDonateBlood => _willingToDonateBlood;

  String? get bloodGroup => _bloodGroup;

  bool? get isExpat => _isExpat;

  String? get country => _country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_reg_no'] = _userRegNo;
    map['f_name'] = _fName;
    map['l_name'] = _lName;
    map['house_id'] = _houseId;
    map['house_name'] = _houseName;
    map['house_reg_no'] = _houseRegNo;
    map['phone'] = _phone;
    map['due'] = _due;
    map['total_due'] = _totalDue;
    map['place'] = _place;
    map['state'] = _state;
    map['district'] = _district;
    map['gender'] = _gender;
    map['dob'] = _dob;
    map['age'] = _age;
    map['job'] = _job;
    map['annual_income'] = _annualIncome;
    map['willing_to_donate_blood'] = _willingToDonateBlood;
    map['blood_group'] = _bloodGroup;
    map['is_expat'] = _isExpat;
    map['country'] = _country;

    return map;
  }
}
