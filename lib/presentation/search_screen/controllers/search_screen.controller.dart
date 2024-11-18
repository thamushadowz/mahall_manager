import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchScreenController extends GetxController {
  final searchController = TextEditingController();
  List<dynamic> itemList = [];
  var filteredList = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    itemList = Get.arguments;
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
        itemList.where(
            (item) => item.name.toLowerCase().contains(query.toLowerCase())),
      );
    }
  }
}
