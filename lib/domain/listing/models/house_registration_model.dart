import 'dart:convert';

/// message : "House retrieved successfully"
/// status : true
/// data : [{"id":9,"name":"kalluv","reg_number":"M001001"},{"id":10,"name":"house 1234","reg_number":"M001002"},{"id":11,"name":"house 1234","reg_number":"2345e456"}]

HouseRegistrationModel houseRegistrationModelFromJson(String str) =>
    HouseRegistrationModel.fromJson(json.decode(str));
String houseRegistrationModelToJson(HouseRegistrationModel data) =>
    json.encode(data.toJson());

class HouseRegistrationModel {
  HouseRegistrationModel({
    String? message,
    bool? status,
    List<HouseData>? data,
  }) {
    _message = message;
    _status = status;
    _data = data;
  }

  HouseRegistrationModel.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(HouseData.fromJson(v));
      });
    }
  }
  String? _message;
  bool? _status;
  List<HouseData>? _data;
  HouseRegistrationModel copyWith({
    String? message,
    bool? status,
    List<HouseData>? data,
  }) =>
      HouseRegistrationModel(
        message: message ?? _message,
        status: status ?? _status,
        data: data ?? _data,
      );
  String? get message => _message;
  bool? get status => _status;
  List<HouseData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 9
/// name : "kalluv"
/// reg_number : "M001001"

HouseData dataFromJson(String str) => HouseData.fromJson(json.decode(str));
String dataToJson(HouseData data) => json.encode(data.toJson());

class HouseData {
  HouseData({
    num? id,
    String? name,
    String? regNumber,
    String? place,
    String? state,
    String? district,
  }) {
    _id = id;
    _name = name;
    _regNumber = regNumber;
    _place = place;
    _state = state;
    _district = district;
  }

  HouseData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _regNumber = json['reg_number'];
    _place = json['place'];
    _state = json['state'];
    _district = json['district'];
  }
  num? _id;
  String? _name;
  String? _regNumber;
  String? _place;
  String? _state;
  String? _district;
  HouseData copyWith({
    num? id,
    String? name,
    String? regNumber,
    String? place,
    String? state,
    String? district,
  }) =>
      HouseData(
        id: id ?? _id,
        name: name ?? _name,
        regNumber: regNumber ?? _regNumber,
        place: place ?? _place,
        state: state ?? _state,
        district: district ?? _district,
      );
  num? get id => _id;
  String? get name => _name;
  String? get regNumber => _regNumber;
  String? get place => _place;
  String? get state => _state;
  String? get district => _district;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['reg_number'] = _regNumber;
    map['place'] = _place;
    map['state'] = _state;
    map['district'] = _district;
    return map;
  }
}
