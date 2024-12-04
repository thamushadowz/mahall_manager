import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/domain/listing/models/dua_model.dart';

class DuasController extends GetxController {
  List<DuaData> duas = [];

  @override
  void onInit() {
    super.onInit();
    getDuaList();
  }

  getDuaList() async {
    String jsonString = await rootBundle.loadString('assets/jsons/duas.json');
    List<dynamic> jsonList = json.decode(jsonString);

    duas = jsonList.map((duaJson) => DuaData.fromJson(duaJson)).toList();

    print('Duas : $duas');
  }
}
