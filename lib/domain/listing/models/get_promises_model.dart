import 'dart:convert';

/// status : "success"
/// message : "PromisesData retrieved successfully"
/// data : [{"user_reg_id":"12345","fName":"John Doe","description":"Payment for services","date":"2024-11-12","amount":150.75,"added_by":"Admin"},{"user_reg_id":"67890","fName":"Jane Smith","description":"Subscription renewal","date":"2024-11-10","amount":99.99,"added_by":"Manager"}]

GetPromisesModel getPromisesModelFromJson(String str) =>
    GetPromisesModel.fromJson(json.decode(str));
String getPromisesModelToJson(GetPromisesModel data) =>
    json.encode(data.toJson());

class GetPromisesModel {
  GetPromisesModel({
    String? status,
    String? message,
    List<PromisesData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetPromisesModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(PromisesData.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  List<PromisesData>? _data;
  GetPromisesModel copyWith({
    String? status,
    String? message,
    List<PromisesData>? data,
  }) =>
      GetPromisesModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  String? get status => _status;
  String? get message => _message;
  List<PromisesData>? get data => _data;

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

/// description : "Payment for services"
/// date : "2024-11-12"
/// amount : 150.75
/// added_by : "Admin"

PromisesData dataFromJson(String str) =>
    PromisesData.fromJson(json.decode(str));
String dataToJson(PromisesData data) => json.encode(data.toJson());

class PromisesData {
  PromisesData({
    String? description,
    String? date,
    String? amount,
    String? addedBy,
  }) {
    _description = description;
    _date = date;
    _amount = amount;
    _addedBy = addedBy;
  }

  PromisesData.fromJson(dynamic json) {
    _description = json['description'];
    _date = json['date'];
    _amount = json['amount'];
    _addedBy = json['added_by'];
  }
  String? _description;
  String? _date;
  String? _amount;
  String? _addedBy;
  PromisesData copyWith({
    String? description,
    String? date,
    String? amount,
    String? addedBy,
  }) =>
      PromisesData(
        description: description ?? _description,
        date: date ?? _date,
        amount: amount ?? _amount,
        addedBy: addedBy ?? _addedBy,
      );
  String? get description => _description;
  String? get date => _date;
  String? get amount => _amount;
  String? get addedBy => _addedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['description'] = _description;
    map['date'] = _date;
    map['amount'] = _amount;
    map['added_by'] = _addedBy;
    return map;
  }
}
