import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mahall_manager/domain/listing/models/dua_model.dart';

class DuasController extends GetxController {
  RxList<DuaData> duas = RxList([]);

  @override
  void onInit() {
    super.onInit();
    getDuaList();
  }

  getDuaList() async {
    String jsonString = await rootBundle.loadString('assets/jsons/duas.json');
    List<dynamic> jsonList = json.decode(jsonString);

    duas.clear();
    duas.addAll(jsonList.map((duaJson) => DuaData.fromJson(duaJson)));
  }
}
