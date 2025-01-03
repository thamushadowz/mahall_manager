import 'dart:convert';

/// status : true
/// message : "Notifications fetched successfully"
/// data : [{"id":1,"posted_by":"President","notification":"This is a sample notification message.","read_status":false,"date":"02/12/2024"},{"id":2,"posted_by":"Secretary","notification":"This is another sample notification message.","read_status":true,"date":"01/12/2024"}]

GetNotificationsModel getNotificationsModelFromJson(String str) =>
    GetNotificationsModel.fromJson(json.decode(str));
String getNotificationsModelToJson(GetNotificationsModel data) =>
    json.encode(data.toJson());

class GetNotificationsModel {
  GetNotificationsModel({
    bool? status,
    String? message,
    List<NotificationsData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetNotificationsModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(NotificationsData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<NotificationsData>? _data;
  GetNotificationsModel copyWith({
    bool? status,
    String? message,
    List<NotificationsData>? data,
  }) =>
      GetNotificationsModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<NotificationsData>? get data => _data;

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
/// posted_by : "President"
/// notification : "This is a sample notification message."
/// read_status : false
/// date : "02/12/2024"

NotificationsData dataFromJson(String str) =>
    NotificationsData.fromJson(json.decode(str));
String dataToJson(NotificationsData data) => json.encode(data.toJson());

class NotificationsData {
  NotificationsData({
    num? id,
    int? postedBy,
    String? designation,
    String? notification,
    bool? readStatus,
    String? date,
  }) {
    _id = id;
    _postedBy = postedBy;
    _designation = designation;
    _notification = notification;
    _readStatus = readStatus;
    _date = date;
  }

  NotificationsData.fromJson(dynamic json) {
    _id = json['id'];
    _postedBy = json['posted_by'];
    _designation = json['designation'];
    _notification = json['notification'];
    _readStatus = json['read_status'];
    _date = json['date'];
  }
  num? _id;
  int? _postedBy;
  String? _designation;
  String? _notification;
  bool? _readStatus;
  String? _date;
  NotificationsData copyWith({
    num? id,
    int? postedBy,
    String? designation,
    String? notification,
    bool? readStatus,
    String? date,
  }) =>
      NotificationsData(
        id: id ?? _id,
        postedBy: postedBy ?? _postedBy,
        designation: designation ?? _designation,
        notification: notification ?? _notification,
        readStatus: readStatus ?? _readStatus,
        date: date ?? _date,
      );
  num? get id => _id;
  int? get postedBy => _postedBy;
  String? get designation => _designation;
  String? get notification => _notification;
  bool? get readStatus => _readStatus;
  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['posted_by'] = _postedBy;
    map['designation'] = _designation;
    map['notification'] = _notification;
    map['read_status'] = _readStatus;
    map['date'] = _date;
    return map;
  }
}
