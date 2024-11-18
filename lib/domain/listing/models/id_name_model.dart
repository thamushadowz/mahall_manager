import 'dart:convert';

/// id : 1
/// name : "Thiruvananthapuram"

IdNameModel idNameModelFromJson(String str) =>
    IdNameModel.fromJson(json.decode(str));
String idNameModelToJson(IdNameModel data) => json.encode(data.toJson());

class IdNameModel {
  IdNameModel({
    num? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  IdNameModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
  IdNameModel copyWith({
    num? id,
    String? name,
  }) =>
      IdNameModel(
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
