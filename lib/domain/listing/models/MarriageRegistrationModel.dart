import 'dart:convert';

/// status : true
/// message : "Marriage registration successful"
/// data : [{"marriage_reg_no":"KNYW01","groom_name":"Anees K","bride_name":"Fathima P","certificate_url":""}]

MarriageRegistrationModel marriageRegistrationModelFromJson(String str) =>
    MarriageRegistrationModel.fromJson(json.decode(str));
String marriageRegistrationModelToJson(MarriageRegistrationModel data) =>
    json.encode(data.toJson());

class MarriageRegistrationModel {
  MarriageRegistrationModel({
    bool? status,
    String? message,
    List<MarriageData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  MarriageRegistrationModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(MarriageData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<MarriageData>? _data;
  MarriageRegistrationModel copyWith({
    bool? status,
    String? message,
    List<MarriageData>? data,
  }) =>
      MarriageRegistrationModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<MarriageData>? get data => _data;

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

/// marriage_reg_no : "KNYW01"
/// groom_name : "Anees K"
/// bride_name : "Fathima P"
/// certificate_url : ""

MarriageData dataFromJson(String str) =>
    MarriageData.fromJson(json.decode(str));
String dataToJson(MarriageData data) => json.encode(data.toJson());

class MarriageData {
  MarriageData({
    String? marriageRegNo,
    String? groomName,
    String? brideName,
    String? certificateUrl,
  }) {
    _marriageRegNo = marriageRegNo;
    _groomName = groomName;
    _brideName = brideName;
    _certificateUrl = certificateUrl;
  }

  MarriageData.fromJson(dynamic json) {
    _marriageRegNo = json['marriage_reg_no'];
    _groomName = json['groom_name'];
    _brideName = json['bride_name'];
    _certificateUrl = json['certificate_url'];
  }
  String? _marriageRegNo;
  String? _groomName;
  String? _brideName;
  String? _certificateUrl;
  MarriageData copyWith({
    String? marriageRegNo,
    String? groomName,
    String? brideName,
    String? certificateUrl,
  }) =>
      MarriageData(
        marriageRegNo: marriageRegNo ?? _marriageRegNo,
        groomName: groomName ?? _groomName,
        brideName: brideName ?? _brideName,
        certificateUrl: certificateUrl ?? _certificateUrl,
      );
  String? get marriageRegNo => _marriageRegNo;
  String? get groomName => _groomName;
  String? get brideName => _brideName;
  String? get certificateUrl => _certificateUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['marriage_reg_no'] = _marriageRegNo;
    map['groom_name'] = _groomName;
    map['bride_name'] = _brideName;
    map['certificate_url'] = _certificateUrl;
    return map;
  }
}
