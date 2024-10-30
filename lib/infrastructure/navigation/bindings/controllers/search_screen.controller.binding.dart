import 'package:get/get.dart';

import '../../../../presentation/search_screen/controllers/search_screen.controller.dart';

class SearchScreenControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchScreenController>(
      () => SearchScreenController(),
    );
  }
}
