import 'dart:convert';

/// status : true
/// message : "Report generated successfully"
/// data : [{"from_date":"18/05/2024","to_date":"31/05/2024","url_link":""}]

GetReportPdfModel getReportPdfModelFromJson(String str) =>
    GetReportPdfModel.fromJson(json.decode(str));
String getReportPdfModelToJson(GetReportPdfModel data) =>
    json.encode(data.toJson());

class GetReportPdfModel {
  GetReportPdfModel({
    bool? status,
    String? message,
    List<ReportPdfData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetReportPdfModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ReportPdfData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<ReportPdfData>? _data;
  GetReportPdfModel copyWith({
    bool? status,
    String? message,
    List<ReportPdfData>? data,
  }) =>
      GetReportPdfModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<ReportPdfData>? get data => _data;

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

/// from_date : "18/05/2024"
/// to_date : "31/05/2024"
/// url_link : ""

ReportPdfData dataFromJson(String str) =>
    ReportPdfData.fromJson(json.decode(str));
String dataToJson(ReportPdfData data) => json.encode(data.toJson());

class ReportPdfData {
  ReportPdfData({
    String? fromDate,
    String? toDate,
    String? urlLink,
  }) {
    _fromDate = fromDate;
    _toDate = toDate;
    _urlLink = urlLink;
  }

  ReportPdfData.fromJson(dynamic json) {
    _fromDate = json['from_date'];
    _toDate = json['to_date'];
    _urlLink = json['url_link'];
  }
  String? _fromDate;
  String? _toDate;
  String? _urlLink;
  ReportPdfData copyWith({
    String? fromDate,
    String? toDate,
    String? urlLink,
  }) =>
      ReportPdfData(
        fromDate: fromDate ?? _fromDate,
        toDate: toDate ?? _toDate,
        urlLink: urlLink ?? _urlLink,
      );
  String? get fromDate => _fromDate;
  String? get toDate => _toDate;
  String? get urlLink => _urlLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['from_date'] = _fromDate;
    map['to_date'] = _toDate;
    map['url_link'] = _urlLink;
    return map;
  }
}
