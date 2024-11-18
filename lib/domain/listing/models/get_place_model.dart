import 'dart:convert';

/// message : "Places retrieved successfully"
/// status : true
/// data : [{"id":1,"name":"Main Hall"}]

GetPlaceModel getPlaceModelFromJson(String str) =>
    GetPlaceModel.fromJson(json.decode(str));
String getPlaceModelToJson(GetPlaceModel data) => json.encode(data.toJson());

class GetPlaceModel {
  GetPlaceModel({
    String? message,
    bool? status,
    List<PlaceData>? data,
  }) {
    _message = message;
    _status = status;
    _data = data;
  }

  GetPlaceModel.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(PlaceData.fromJson(v));
      });
    }
  }
  String? _message;
  bool? _status;
  List<PlaceData>? _data;
  GetPlaceModel copyWith({
    String? message,
    bool? status,
    List<PlaceData>? data,
  }) =>
      GetPlaceModel(
        message: message ?? _message,
        status: status ?? _status,
        data: data ?? _data,
      );
  String? get message => _message;
  bool? get status => _status;
  List<PlaceData>? get data => _data;

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

/// id : 1
/// name : "Main Hall"

PlaceData dataFromJson(String str) => PlaceData.fromJson(json.decode(str));
String dataToJson(PlaceData data) => json.encode(data.toJson());

class PlaceData {
  PlaceData({
    num? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  PlaceData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
  PlaceData copyWith({
    num? id,
    String? name,
  }) =>
      PlaceData(
        id: id ?? _id,
        name: name ?? _name,
      );
  num? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}
