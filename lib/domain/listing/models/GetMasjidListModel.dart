import 'dart:convert';

/// status : true
/// data : [{"id":1,"name":"masjid name","code":"ABCD"},{"id":2,"name":"masjid name 1","code":"BCDE"}]

GetMasjidListModel getMasjidListModelFromJson(String str) =>
    GetMasjidListModel.fromJson(json.decode(str));
String getMasjidListModelToJson(GetMasjidListModel data) =>
    json.encode(data.toJson());

class GetMasjidListModel {
  GetMasjidListModel({
    bool? status,
    String? message,
    List<MasjidListData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetMasjidListModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(MasjidListData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<MasjidListData>? _data;
  GetMasjidListModel copyWith({
    bool? status,
    String? message,
    List<MasjidListData>? data,
  }) =>
      GetMasjidListModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<MasjidListData>? get data => _data;

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
/// name : "masjid name"
/// code : "ABCD"

MasjidListData dataFromJson(String str) =>
    MasjidListData.fromJson(json.decode(str));
String dataToJson(MasjidListData data) => json.encode(data.toJson());

class MasjidListData {
  MasjidListData({
    num? id,
    String? name,
    String? code,
  }) {
    _id = id;
    _name = name;
    _code = code;
  }

  MasjidListData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _code = json['code'];
  }
  num? _id;
  String? _name;
  String? _code;
  MasjidListData copyWith({
    num? id,
    String? name,
    String? code,
  }) =>
      MasjidListData(
        id: id ?? _id,
        name: name ?? _name,
        code: code ?? _code,
      );
  num? get id => _id;
  String? get name => _name;
  String? get code => _code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['code'] = _code;
    return map;
  }
}
