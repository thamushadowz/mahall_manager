import 'dart:convert';

/// masjid : {"id":1,"name":"Masjid Al-Falah12","address":"123 Main St, City","pincode":123456,"code":"FGDS","status":0}
/// admins : [{"id":2,"first_name":"asfsd","last_name":"vvv","phone":"8454567410","masjid_role":1},{"id":3,"first_name":"ajj","last_name":"vvv","phone":"8454567890","masjid_role":0},{"id":4,"first_name":"ajj","last_name":"vvv","phone":"8454567850","masjid_role":2}]
/// message : "Masjid and admin details were fetched successfully"
/// status : true

MahallRegistrationOrDetailsModel mahallRegistrationOrDetailsModelFromJson(
        String str) =>
    MahallRegistrationOrDetailsModel.fromJson(json.decode(str));
String mahallRegistrationOrDetailsModelToJson(
        MahallRegistrationOrDetailsModel data) =>
    json.encode(data.toJson());

class MahallRegistrationOrDetailsModel {
  MahallRegistrationOrDetailsModel({
    Masjid? masjid,
    List<GetAdmins>? admins,
    String? message,
    bool? status,
  }) {
    _masjid = masjid;
    _admins = admins;
    _message = message;
    _status = status;
  }

  MahallRegistrationOrDetailsModel.fromJson(dynamic json) {
    _masjid = json['masjid'] != null ? Masjid.fromJson(json['masjid']) : null;
    if (json['admins'] != null) {
      _admins = [];
      json['admins'].forEach((v) {
        _admins?.add(GetAdmins.fromJson(v));
      });
    }
    _message = json['message'];
    _status = json['status'];
  }
  Masjid? _masjid;
  List<GetAdmins>? _admins;
  String? _message;
  bool? _status;
  MahallRegistrationOrDetailsModel copyWith({
    Masjid? masjid,
    List<GetAdmins>? admins,
    String? message,
    bool? status,
  }) =>
      MahallRegistrationOrDetailsModel(
        masjid: masjid ?? _masjid,
        admins: admins ?? _admins,
        message: message ?? _message,
        status: status ?? _status,
      );
  Masjid? get masjid => _masjid;
  List<GetAdmins>? get admins => _admins;
  String? get message => _message;
  bool? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_masjid != null) {
      map['masjid'] = _masjid?.toJson();
    }
    if (_admins != null) {
      map['admins'] = _admins?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    map['status'] = _status;
    return map;
  }
}

/// id : 2
/// first_name : "asfsd"
/// last_name : "vvv"
/// phone : "8454567410"
/// masjid_role : 1

GetAdmins adminsFromJson(String str) => GetAdmins.fromJson(json.decode(str));
String adminsToJson(GetAdmins data) => json.encode(data.toJson());

class GetAdmins {
  GetAdmins({
    num? id,
    String? firstName,
    String? lastName,
    String? phone,
    num? masjidRole,
  }) {
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _phone = phone;
    _masjidRole = masjidRole;
  }

  GetAdmins.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _phone = json['phone'];
    _masjidRole = json['masjid_role'];
  }
  num? _id;
  String? _firstName;
  String? _lastName;
  String? _phone;
  num? _masjidRole;
  GetAdmins copyWith({
    num? id,
    String? firstName,
    String? lastName,
    String? phone,
    num? masjidRole,
  }) =>
      GetAdmins(
        id: id ?? _id,
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
        phone: phone ?? _phone,
        masjidRole: masjidRole ?? _masjidRole,
      );
  num? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get phone => _phone;
  num? get masjidRole => _masjidRole;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['phone'] = _phone;
    map['masjid_role'] = _masjidRole;
    return map;
  }
}

/// id : 1
/// name : "Masjid Al-Falah12"
/// address : "123 Main St, City"
/// pincode : 123456
/// code : "FGDS"
/// status : 0

Masjid masjidFromJson(String str) => Masjid.fromJson(json.decode(str));
String masjidToJson(Masjid data) => json.encode(data.toJson());

class Masjid {
  Masjid({
    num? id,
    String? name,
    String? address,
    num? pincode,
    String? code,
    num? status,
  }) {
    _id = id;
    _name = name;
    _address = address;
    _pincode = pincode;
    _code = code;
    _status = status;
  }

  Masjid.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _address = json['address'];
    _pincode = json['pincode'];
    _code = json['code'];
    _status = json['status'];
  }
  num? _id;
  String? _name;
  String? _address;
  num? _pincode;
  String? _code;
  num? _status;
  Masjid copyWith({
    num? id,
    String? name,
    String? address,
    num? pincode,
    String? code,
    num? status,
  }) =>
      Masjid(
        id: id ?? _id,
        name: name ?? _name,
        address: address ?? _address,
        pincode: pincode ?? _pincode,
        code: code ?? _code,
        status: status ?? _status,
      );
  num? get id => _id;
  String? get name => _name;
  String? get address => _address;
  num? get pincode => _pincode;
  String? get code => _code;
  num? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['address'] = _address;
    map['pincode'] = _pincode;
    map['code'] = _code;
    map['status'] = _status;
    return map;
  }
}
