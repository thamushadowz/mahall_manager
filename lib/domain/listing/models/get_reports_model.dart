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

///id : 1
/// description : "Electricity Bill Payment"
/// date : "2024/11/01"
/// isSharable : true
/// incomeOrExpense : 0/1
/// amount : 100
/// addedBy : "Admin"

ReportsData dataFromJson(String str) => ReportsData.fromJson(json.decode(str));
String dataToJson(ReportsData data) => json.encode(data.toJson());

class ReportsData {
  ReportsData({
    String? id,
    String? description,
    String? date,
    bool? isSharable,
    int? currentDue,
    String? incomeOrExpense,
    String? amount,
    String? addedBy,
  }) {
    _id = id;
    _description = description;
    _date = date;
    _isSharable = isSharable;
    _currentDue = currentDue;
    _incomeOrExpense = incomeOrExpense;
    _amount = amount;
    _addedBy = addedBy;
  }

  ReportsData.fromJson(dynamic json) {
    _id = json['id'];
    _description = json['description'];
    _date = json['date'];
    _isSharable = json['isSharable'];
    _currentDue = json['currentDue'];
    _incomeOrExpense = json['incomeOrExpense'];
    _amount = json['amount'];
    _addedBy = json['addedBy'];
  }
  String? _id;
  String? _description;
  String? _date;
  bool? _isSharable;
  int? _currentDue;
  String? _incomeOrExpense;
  String? _amount;
  String? _addedBy;
  ReportsData copyWith({
    String? id,
    String? description,
    String? date,
    bool? isSharable,
    int? currentDue,
    String? incomeOrExpense,
    String? amount,
    String? addedBy,
  }) =>
      ReportsData(
        id: id ?? _id,
        description: description ?? _description,
        date: date ?? _date,
        isSharable: isSharable ?? _isSharable,
        currentDue: currentDue ?? _currentDue,
        incomeOrExpense: incomeOrExpense ?? _incomeOrExpense,
        amount: amount ?? _amount,
        addedBy: addedBy ?? _addedBy,
      );
  String? get id => _id;
  String? get description => _description;
  String? get date => _date;
  bool? get isSharable => _isSharable;
  int? get currentDue => _currentDue;
  String? get incomeOrExpense => _incomeOrExpense;
  String? get amount => _amount;
  String? get addedBy => _addedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['description'] = _description;
    map['date'] = _date;
    map['isSharable'] = _isSharable;
    map['currentDue'] = _currentDue;
    map['incomeOrExpense'] = _incomeOrExpense;
    map['amount'] = _amount;
    map['addedBy'] = _addedBy;
    return map;
  }
}
