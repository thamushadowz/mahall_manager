import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddExpensesController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final dateController = TextEditingController();
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();

  final dateFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final amountFocusNode = FocusNode();
}
