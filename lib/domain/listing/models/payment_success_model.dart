import 'dart:convert';

/// status : true
/// message : "Payment recieved successfully"
/// data : {"reference_no":"KNJ0001","current_due":1000}

PaymentSuccessModel paymentSuccessModelFromJson(String str) =>
    PaymentSuccessModel.fromJson(json.decode(str));
String paymentSuccessModelToJson(PaymentSuccessModel data) =>
    json.encode(data.toJson());

class PaymentSuccessModel {
  PaymentSuccessModel({
    bool? status,
    String? message,
    PaymentData? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  PaymentSuccessModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? PaymentData.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  PaymentData? _data;
  PaymentSuccessModel copyWith({
    bool? status,
    String? message,
    PaymentData? data,
  }) =>
      PaymentSuccessModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  PaymentData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// reference_no : "KNJ0001"
/// current_due : 1000

PaymentData dataFromJson(String str) => PaymentData.fromJson(json.decode(str));
String dataToJson(PaymentData data) => json.encode(data.toJson());

class PaymentData {
  PaymentData({
    String? referenceNo,
    num? currentDue,
  }) {
    _referenceNo = referenceNo;
    _currentDue = currentDue;
  }

  PaymentData.fromJson(dynamic json) {
    _referenceNo = json['reference_no'];
    _currentDue = json['current_due'];
  }
  String? _referenceNo;
  num? _currentDue;
  PaymentData copyWith({
    String? referenceNo,
    num? currentDue,
  }) =>
      PaymentData(
        referenceNo: referenceNo ?? _referenceNo,
        currentDue: currentDue ?? _currentDue,
      );
  String? get referenceNo => _referenceNo;
  num? get currentDue => _currentDue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['reference_no'] = _referenceNo;
    map['current_due'] = _currentDue;
    return map;
  }
}
