import 'dart:convert';

/// status : true
/// message : "Deceased list fetched successfully"
/// data : [{"id":1,"house_reg_no":"KNY01","house_name":"White House","person_name":"Abdullah","place":"Kayani"},{"id":2,"house_reg_no":"KNY02","house_name":"White House","person_name":"Abdullah","place":"Kayani"}]

GetDeceasedListModel getDeceasedListModelFromJson(String str) =>
    GetDeceasedListModel.fromJson(json.decode(str));
String getDeceasedListModelToJson(GetDeceasedListModel data) =>
    json.encode(data.toJson());

class GetDeceasedListModel {
  GetDeceasedListModel({
    bool? status,
    String? message,
    List<DeceasedData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetDeceasedListModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(DeceasedData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<DeceasedData>? _data;
  GetDeceasedListModel copyWith({
    bool? status,
    String? message,
    List<DeceasedData>? data,
  }) =>
      GetDeceasedListModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<DeceasedData>? get data => _data;

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

/// id : 1
/// house_reg_no : "KNY01"
/// house_name : "White House"
/// person_name : "Abdullah"
/// place : "Kayani"

DeceasedData dataFromJson(String str) =>
    DeceasedData.fromJson(json.decode(str));
String dataToJson(DeceasedData data) => json.encode(data.toJson());

class DeceasedData {
  DeceasedData({
    num? id,
    String? houseRegNo,
    String? houseName,
    String? personName,
    String? place,
  }) {
    _id = id;
    _houseRegNo = houseRegNo;
    _houseName = houseName;
    _personName = personName;
    _place = place;
  }

  DeceasedData.fromJson(dynamic json) {
    _id = json['id'];
    _houseRegNo = json['house_reg_no'];
    _houseName = json['house_name'];
    _personName = json['person_name'];
    _place = json['place'];
  }
  num? _id;
  String? _houseRegNo;
  String? _houseName;
  String? _personName;
  String? _place;
  DeceasedData copyWith({
    num? id,
    String? houseRegNo,
    String? houseName,
    String? personName,
    String? place,
  }) =>
      DeceasedData(
        id: id ?? _id,
        houseRegNo: houseRegNo ?? _houseRegNo,
        houseName: houseName ?? _houseName,
        personName: personName ?? _personName,
        place: place ?? _place,
      );
  num? get id => _id;
  String? get houseRegNo => _houseRegNo;
  String? get houseName => _houseName;
  String? get personName => _personName;
  String? get place => _place;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['house_reg_no'] = _houseRegNo;
    map['house_name'] = _houseName;
    map['person_name'] = _personName;
    map['place'] = _place;
    return map;
  }
}
