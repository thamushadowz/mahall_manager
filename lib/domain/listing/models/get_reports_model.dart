import 'dart:convert';

/// status : true
/// message : "ReportsData fetched successfully"
/// data : [{"description":"Electricity Bill Payment","date":"2024/11/01","incomeOrExpense":"Expense","amount":100,"addedBy":"Admin"},{"description":"Salary Income","date":"2024/11/03","incomeOrExpense":"Income","amount":1000,"addedBy":"Admin"},{"description":"Office Supplies Purchase","date":"2024/11/05","incomeOrExpense":"Expense","amount":50,"addedBy":"Manager"}]

GetReportsModel getReportsModelFromJson(String str) =>
    GetReportsModel.fromJson(json.decode(str));
String getReportsModelToJson(GetReportsModel data) =>
    json.encode(data.toJson());

class GetReportsModel {
  GetReportsModel({
    bool? status,
    String? message,
    List<ReportsData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetReportsModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ReportsData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<ReportsData>? _data;
  GetReportsModel copyWith({
    bool? status,
    String? message,
    List<ReportsData>? data,
  }) =>
      GetReportsModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<ReportsData>? get data => _data;

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

/// description : "Electricity Bill Payment"
/// date : "2024/11/01"
/// incomeOrExpense : 0/1
/// amount : 100
/// addedBy : "Admin"

ReportsData dataFromJson(String str) => ReportsData.fromJson(json.decode(str));
String dataToJson(ReportsData data) => json.encode(data.toJson());

class ReportsData {
  ReportsData({
    String? description,
    String? date,
    num? incomeOrExpense,
    num? amount,
    String? addedBy,
  }) {
    _description = description;
    _date = date;
    _incomeOrExpense = incomeOrExpense;
    _amount = amount;
    _addedBy = addedBy;
  }

  ReportsData.fromJson(dynamic json) {
    _description = json['description'];
    _date = json['date'];
    _incomeOrExpense = json['incomeOrExpense'];
    _amount = json['amount'];
    _addedBy = json['addedBy'];
  }
  String? _description;
  String? _date;
  num? _incomeOrExpense;
  num? _amount;
  String? _addedBy;
  ReportsData copyWith({
    String? description,
    String? date,
    num? incomeOrExpense,
    num? amount,
    String? addedBy,
  }) =>
      ReportsData(
        description: description ?? _description,
        date: date ?? _date,
        incomeOrExpense: incomeOrExpense ?? _incomeOrExpense,
        amount: amount ?? _amount,
        addedBy: addedBy ?? _addedBy,
      );
  String? get description => _description;
  String? get date => _date;
  num? get incomeOrExpense => _incomeOrExpense;
  num? get amount => _amount;
  String? get addedBy => _addedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['description'] = _description;
    map['date'] = _date;
    map['incomeOrExpense'] = _incomeOrExpense;
    map['amount'] = _amount;
    map['addedBy'] = _addedBy;
    return map;
  }
}
