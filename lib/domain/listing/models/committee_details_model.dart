import 'dart:convert';

/// status : true
/// message : "Committee details added successfully"
/// data : [{"id":0,"designation":"President","name":"Abdullah","phone":"9192939495"},{"id":1,"designation":"Secretary","name":"test1","phone":"9897949596"}]

CommitteeDetailsModel committeeDetailsModelFromJson(String str) =>
    CommitteeDetailsModel.fromJson(json.decode(str));

String committeeDetailsModelToJson(CommitteeDetailsModel data) =>
    json.encode(data.toJson());

class CommitteeDetailsModel {
  CommitteeDetailsModel({
    bool? status,
    String? message,
    List<CommitteeDetailsData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  CommitteeDetailsModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CommitteeDetailsData.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  List<CommitteeDetailsData>? _data;

  CommitteeDetailsModel copyWith({
    bool? status,
    String? message,
    List<CommitteeDetailsData>? data,
  }) =>
      CommitteeDetailsModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  String? get message => _message;

  List<CommitteeDetailsData>? get data => _data;

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

/// id : 0
/// designation : "President"
/// name : "Abdullah"
/// phone : "9192939495"

CommitteeDetailsData dataFromJson(String str) =>
    CommitteeDetailsData.fromJson(json.decode(str));

String dataToJson(CommitteeDetailsData data) => json.encode(data.toJson());

class CommitteeDetailsData {
  CommitteeDetailsData({
    num? id,
    String? designation,
    String? name,
    String? phone,
  }) {
    _id = id;
    _designation = designation;
    _name = name;
    _phone = phone;
  }

  CommitteeDetailsData.fromJson(dynamic json) {
    _id = json['id'];
    _designation = json['designation'];
    _name = json['name'];
    _phone = json['phone'];
  }

  num? _id;
  String? _designation;
  String? _name;
  String? _phone;

  CommitteeDetailsData copyWith({
    num? id,
    String? designation,
    String? name,
    String? phone,
  }) =>
      CommitteeDetailsData(
        id: id ?? _id,
        designation: designation ?? _designation,
        name: name ?? _name,
        phone: phone ?? _phone,
      );

  num? get id => _id;

  String? get designation => _designation;

  String? get name => _name;

  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['designation'] = _designation;
    map['name'] = _name;
    map['phone'] = _phone;
    return map;
  }
}
