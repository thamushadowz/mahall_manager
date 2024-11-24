import 'dart:convert';

/// register_no : "KNYW01"
/// groom_name : "Anees K"
/// groom_father_name : "Abootty K"
/// groom_mother_name : "Aysha M"
/// is_groom_mahallee : true
/// groom_house_id : 15
/// groom_address : "White House, Kayani, Kannur, Kerala."
/// groom_phone : "9897949596"
/// bride_name : "Anees K"
/// bride_father_name : "Abootty K"
/// bride_mother_name : "Aysha M"
/// is_bride_mahallee : false
/// bride_house_id : null
/// bride_address : "White House, Kayani, Kannur, Kerala."
/// bride_phone : "9897949596"
/// witness1_name : "Muhammed P"
/// witness1_phone : "9897949596"
/// witness2_name : "Muhammed P"
/// witness2_phone : "9897949596"

MarriageRegistrationInputModel marriageRegistrationInputModelFromJson(
        String str) =>
    MarriageRegistrationInputModel.fromJson(json.decode(str));
String marriageRegistrationInputModelToJson(
        MarriageRegistrationInputModel data) =>
    json.encode(data.toJson());

class MarriageRegistrationInputModel {
  MarriageRegistrationInputModel({
    String? registerNo,
    String? groomName,
    String? groomFatherName,
    String? groomMotherName,
    bool? isGroomMahallee,
    num? groomHouseId,
    String? groomAddress,
    String? groomPhone,
    String? brideName,
    String? brideFatherName,
    String? brideMotherName,
    bool? isBrideMahallee,
    dynamic brideHouseId,
    String? brideAddress,
    String? bridePhone,
    String? witness1Name,
    String? witness1Phone,
    String? witness2Name,
    String? witness2Phone,
  }) {
    _registerNo = registerNo;
    _groomName = groomName;
    _groomFatherName = groomFatherName;
    _groomMotherName = groomMotherName;
    _isGroomMahallee = isGroomMahallee;
    _groomHouseId = groomHouseId;
    _groomAddress = groomAddress;
    _groomPhone = groomPhone;
    _brideName = brideName;
    _brideFatherName = brideFatherName;
    _brideMotherName = brideMotherName;
    _isBrideMahallee = isBrideMahallee;
    _brideHouseId = brideHouseId;
    _brideAddress = brideAddress;
    _bridePhone = bridePhone;
    _witness1Name = witness1Name;
    _witness1Phone = witness1Phone;
    _witness2Name = witness2Name;
    _witness2Phone = witness2Phone;
  }

  MarriageRegistrationInputModel.fromJson(dynamic json) {
    _registerNo = json['register_no'];
    _groomName = json['groom_name'];
    _groomFatherName = json['groom_father_name'];
    _groomMotherName = json['groom_mother_name'];
    _isGroomMahallee = json['is_groom_mahallee'];
    _groomHouseId = json['groom_house_id'];
    _groomAddress = json['groom_address'];
    _groomPhone = json['groom_phone'];
    _brideName = json['bride_name'];
    _brideFatherName = json['bride_father_name'];
    _brideMotherName = json['bride_mother_name'];
    _isBrideMahallee = json['is_bride_mahallee'];
    _brideHouseId = json['bride_house_id'];
    _brideAddress = json['bride_address'];
    _bridePhone = json['bride_phone'];
    _witness1Name = json['witness1_name'];
    _witness1Phone = json['witness1_phone'];
    _witness2Name = json['witness2_name'];
    _witness2Phone = json['witness2_phone'];
  }
  String? _registerNo;
  String? _groomName;
  String? _groomFatherName;
  String? _groomMotherName;
  bool? _isGroomMahallee;
  num? _groomHouseId;
  String? _groomAddress;
  String? _groomPhone;
  String? _brideName;
  String? _brideFatherName;
  String? _brideMotherName;
  bool? _isBrideMahallee;
  dynamic _brideHouseId;
  String? _brideAddress;
  String? _bridePhone;
  String? _witness1Name;
  String? _witness1Phone;
  String? _witness2Name;
  String? _witness2Phone;
  MarriageRegistrationInputModel copyWith({
    String? registerNo,
    String? groomName,
    String? groomFatherName,
    String? groomMotherName,
    bool? isGroomMahallee,
    num? groomHouseId,
    String? groomAddress,
    String? groomPhone,
    String? brideName,
    String? brideFatherName,
    String? brideMotherName,
    bool? isBrideMahallee,
    dynamic brideHouseId,
    String? brideAddress,
    String? bridePhone,
    String? witness1Name,
    String? witness1Phone,
    String? witness2Name,
    String? witness2Phone,
  }) =>
      MarriageRegistrationInputModel(
        registerNo: registerNo ?? _registerNo,
        groomName: groomName ?? _groomName,
        groomFatherName: groomFatherName ?? _groomFatherName,
        groomMotherName: groomMotherName ?? _groomMotherName,
        isGroomMahallee: isGroomMahallee ?? _isGroomMahallee,
        groomHouseId: groomHouseId ?? _groomHouseId,
        groomAddress: groomAddress ?? _groomAddress,
        groomPhone: groomPhone ?? _groomPhone,
        brideName: brideName ?? _brideName,
        brideFatherName: brideFatherName ?? _brideFatherName,
        brideMotherName: brideMotherName ?? _brideMotherName,
        isBrideMahallee: isBrideMahallee ?? _isBrideMahallee,
        brideHouseId: brideHouseId ?? _brideHouseId,
        brideAddress: brideAddress ?? _brideAddress,
        bridePhone: bridePhone ?? _bridePhone,
        witness1Name: witness1Name ?? _witness1Name,
        witness1Phone: witness1Phone ?? _witness1Phone,
        witness2Name: witness2Name ?? _witness2Name,
        witness2Phone: witness2Phone ?? _witness2Phone,
      );
  String? get registerNo => _registerNo;
  String? get groomName => _groomName;
  String? get groomFatherName => _groomFatherName;
  String? get groomMotherName => _groomMotherName;
  bool? get isGroomMahallee => _isGroomMahallee;
  num? get groomHouseId => _groomHouseId;
  String? get groomAddress => _groomAddress;
  String? get groomPhone => _groomPhone;
  String? get brideName => _brideName;
  String? get brideFatherName => _brideFatherName;
  String? get brideMotherName => _brideMotherName;
  bool? get isBrideMahallee => _isBrideMahallee;
  dynamic get brideHouseId => _brideHouseId;
  String? get brideAddress => _brideAddress;
  String? get bridePhone => _bridePhone;
  String? get witness1Name => _witness1Name;
  String? get witness1Phone => _witness1Phone;
  String? get witness2Name => _witness2Name;
  String? get witness2Phone => _witness2Phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['register_no'] = _registerNo;
    map['groom_name'] = _groomName;
    map['groom_father_name'] = _groomFatherName;
    map['groom_mother_name'] = _groomMotherName;
    map['is_groom_mahallee'] = _isGroomMahallee;
    map['groom_house_id'] = _groomHouseId;
    map['groom_address'] = _groomAddress;
    map['groom_phone'] = _groomPhone;
    map['bride_name'] = _brideName;
    map['bride_father_name'] = _brideFatherName;
    map['bride_mother_name'] = _brideMotherName;
    map['is_bride_mahallee'] = _isBrideMahallee;
    map['bride_house_id'] = _brideHouseId;
    map['bride_address'] = _brideAddress;
    map['bride_phone'] = _bridePhone;
    map['witness1_name'] = _witness1Name;
    map['witness1_phone'] = _witness1Phone;
    map['witness2_name'] = _witness2Name;
    map['witness2_phone'] = _witness2Phone;
    return map;
  }
}
