import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchScreenController extends GetxController {
  final searchController = TextEditingController();
  late final List<String> itemList;
  var filteredList = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    itemList = List<String>.from(Get.arguments ?? []);
    filteredList.assignAll(itemList);

    searchController.addListener(() {
      filterList(searchController.text);
    });
  }

  void filterList(String query) {
    if (query.isEmpty) {
      filteredList.assignAll(itemList);
    } else {
      filteredList.assignAll(
        itemList
            .where((item) => item.toLowerCase().contains(query.toLowerCase())),
      );
    }
  }
}
