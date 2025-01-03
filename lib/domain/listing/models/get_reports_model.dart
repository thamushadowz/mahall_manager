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
    int? totalPages,
  }) {
    _status = status;
    _message = message;
    _data = data;
    _totalPages = totalPages;
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
    _totalPages = json['total_pages'];
  }
  bool? _status;
  String? _message;
  List<ReportsData>? _data;
  int? _totalPages;
  GetReportsModel copyWith({
    bool? status,
    String? message,
    List<ReportsData>? data,
    int? totalPages,
  }) =>
      GetReportsModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
        totalPages: totalPages ?? _totalPages,
      );
  bool? get status => _status;
  String? get message => _message;
  List<ReportsData>? get data => _data;
  int? get totalPages => _totalPages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['total_pages'] = _totalPages;
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
    int? id,
    String? referenceNo,
    String? description,
    String? date,
    bool? isSharable,
    String? currentDue,
    String? incomeOrExpense,
    String? amount,
    String? designation,
    num? addedBy,
  }) {
    _id = id;
    _referenceNo = referenceNo;
    _description = description;
    _date = date;
    _isSharable = isSharable;
    _currentDue = currentDue;
    _incomeOrExpense = incomeOrExpense;
    _amount = amount;
    _designation = designation;
    _addedBy = addedBy;
  }

  ReportsData.fromJson(dynamic json) {
    _id = json['id'];
    _referenceNo = json['reference_no'];
    _description = json['description'];
    _date = json['date'];
    _isSharable = json['isSharable'];
    _currentDue = json['currentDue'];
    _incomeOrExpense = json['incomeOrExpense'];
    _amount = json['amount'];
    _designation = json['designation'];
    _addedBy = json['added_by'];
  }
  int? _id;
  String? _referenceNo;
  String? _description;
  String? _date;
  bool? _isSharable;
  String? _currentDue;
  String? _incomeOrExpense;
  String? _amount;
  String? _designation;
  num? _addedBy;
  ReportsData copyWith({
    int? id,
    String? referenceNo,
    String? description,
    String? date,
    bool? isSharable,
    String? currentDue,
    String? incomeOrExpense,
    String? amount,
    String? designation,
    num? addedBy,
  }) =>
      ReportsData(
        id: id ?? _id,
        referenceNo: referenceNo ?? _referenceNo,
        description: description ?? _description,
        date: date ?? _date,
        isSharable: isSharable ?? _isSharable,
        currentDue: currentDue ?? _currentDue,
        incomeOrExpense: incomeOrExpense ?? _incomeOrExpense,
        amount: amount ?? _amount,
        designation: designation ?? _designation,
        addedBy: addedBy ?? _addedBy,
      );
  int? get id => _id;
  String? get referenceNo => _referenceNo;
  String? get description => _description;
  String? get date => _date;
  bool? get isSharable => _isSharable;
  String? get currentDue => _currentDue;
  String? get incomeOrExpense => _incomeOrExpense;
  String? get amount => _amount;
  String? get designation => _designation;
  num? get addedBy => _addedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['reference_no'] = _referenceNo;
    map['description'] = _description;
    map['date'] = _date;
    map['isSharable'] = _isSharable;
    map['currentDue'] = _currentDue;
    map['incomeOrExpense'] = _incomeOrExpense;
    map['amount'] = _amount;
    map['designation'] = _designation;
    map['added_by'] = _addedBy;
    return map;
  }
}
