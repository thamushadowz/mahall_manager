import 'dart:convert';

/// status : true
/// message : "Details fetched successfully"
/// data : {"mahall_name":"Kayani Mahall","total_income":"120000","total_expense":"110000"}

ChartDataModel chartDataModelFromJson(String str) =>
    ChartDataModel.fromJson(json.decode(str));

String chartDataModelToJson(ChartDataModel data) => json.encode(data.toJson());

class ChartDataModel {
  ChartDataModel({
    bool? status,
    String? message,
    ChartData? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  ChartDataModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? ChartData.fromJson(json['data']) : null;
  }

  bool? _status;
  String? _message;
  ChartData? _data;

  ChartDataModel copyWith({
    bool? status,
    String? message,
    ChartData? data,
  }) =>
      ChartDataModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get status => _status;

  String? get message => _message;

  ChartData? get data => _data;

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

/// mahall_name : "Kayani Mahall"
/// total_income : "120000"
/// total_expense : "110000"
/// notification_count : 4

ChartData dataFromJson(String str) => ChartData.fromJson(json.decode(str));

String dataToJson(ChartData data) => json.encode(data.toJson());

class ChartData {
  ChartData({
    String? mahallName,
    String? totalIncome,
    String? totalExpense,
    String? notificationCount,
  }) {
    _mahallName = mahallName;
    _totalIncome = totalIncome;
    _totalExpense = totalExpense;
    _notificationCount = notificationCount;
  }

  ChartData.fromJson(dynamic json) {
    _mahallName = json['mahall_name'];
    _totalIncome = json['total_income'];
    _totalExpense = json['total_expense'];
    _notificationCount = json['notification_count'];
  }

  String? _mahallName;
  String? _totalIncome;
  String? _totalExpense;
  String? _notificationCount;

  ChartData copyWith({
    String? mahallName,
    String? totalIncome,
    String? totalExpense,
    String? notificationCount,
  }) =>
      ChartData(
        mahallName: mahallName ?? _mahallName,
        totalIncome: totalIncome ?? _totalIncome,
        totalExpense: totalExpense ?? _totalExpense,
        notificationCount: notificationCount ?? _notificationCount,
      );

  String? get mahallName => _mahallName;

  String? get totalIncome => _totalIncome;

  String? get totalExpense => _totalExpense;

  String? get notificationCount => _notificationCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mahall_name'] = _mahallName;
    map['total_income'] = _totalIncome;
    map['total_expense'] = _totalExpense;
    map['notification_count'] = _notificationCount;
    return map;
  }
}
