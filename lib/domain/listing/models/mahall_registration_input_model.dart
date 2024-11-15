import 'dart:convert';

/// name : "Kayani masjid"
/// address : "sgfdfgfh"
/// pincode : 670702
/// code : "SDGD"
/// admins : [{"masjid_role":0,"first_name":"","last_name":"","phone_number":4645656},{"masjid_role":1,"first_name":"","last_name":"","phone_number":4645646}]

MahallRegistrationInputModel mahallRegistrationInputModelFromJson(String str) =>
    MahallRegistrationInputModel.fromJson(json.decode(str));
String mahallRegistrationInputModelToJson(MahallRegistrationInputModel data) =>
    json.encode(data.toJson());

class MahallRegistrationInputModel {
  MahallRegistrationInputModel({
    String? name,
    String? address,
    num? pincode,
    String? code,
    List<Admins>? admins,
  }) {
    _name = name;
    _address = address;
    _pincode = pincode;
    _code = code;
    _admins = admins;
  }

  MahallRegistrationInputModel.fromJson(dynamic json) {
    _name = json['name'];
    _address = json['address'];
    _pincode = json['pincode'];
    _code = json['code'];
    if (json['admins'] != null) {
      _admins = [];
      json['admins'].forEach((v) {
        _admins?.add(Admins.fromJson(v));
      });
    }
  }
  String? _name;
  String? _address;
  num? _pincode;
  String? _code;
  List<Admins>? _admins;
  MahallRegistrationInputModel copyWith({
    String? name,
    String? address,
    num? pincode,
    String? code,
    List<Admins>? admins,
  }) =>
      MahallRegistrationInputModel(
        name: name ?? _name,
        address: address ?? _address,
        pincode: pincode ?? _pincode,
        code: code ?? _code,
        admins: admins ?? _admins,
      );
  String? get name => _name;
  String? get address => _address;
  num? get pincode => _pincode;
  String? get code => _code;
  List<Admins>? get admins => _admins;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['address'] = _address;
    map['pincode'] = _pincode;
    map['code'] = _code;
    if (_admins != null) {
      map['admins'] = _admins?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// role : 0
/// first_name : ""
/// last_name : ""
/// phone : 4645656

Admins adminsFromJson(String str) => Admins.fromJson(json.decode(str));
String adminsToJson(Admins data) => json.encode(data.toJson());

class Admins {
  Admins({
    num? role,
    String? firstName,
    String? lastName,
    num? phone,
  }) {
    _role = role;
    _firstName = firstName;
    _lastName = lastName;
    _phone = phone;
  }

  Admins.fromJson(dynamic json) {
    _role = json['role'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _phone = json['phone'];
  }
  num? _role;
  String? _firstName;
  String? _lastName;
  num? _phone;
  Admins copyWith({
    num? role,
    String? firstName,
    String? lastName,
    num? phone,
  }) =>
      Admins(
        role: role ?? _role,
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
        phone: phone ?? _phone,
      );
  num? get role => _role;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  num? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['role'] = _role;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['phone'] = _phone;
    return map;
  }
}
