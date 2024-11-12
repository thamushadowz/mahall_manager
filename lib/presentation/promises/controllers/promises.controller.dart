import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PromisesController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;
  final dateController = TextEditingController();
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();

  final dateFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final amountFocusNode = FocusNode();
}
