import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_app_laravel/app/modules/home/providers/task_provider.dart';

class HomeController extends GetxController {
  var lstTask = List<dynamic>.empty(growable: true).obs;
  var page = 1;
  var isDataProcessing = false.obs;
  @override
  void onInit() async {
    super.onInit();
    // Fetch Data
    getTask(page);
  }
  // Fetch Data
  void getTask(var page) {
    try {
      isDataProcessing(true);
      TaskProvider().getTask(page).then((resp) {
        isDataProcessing(false);
        lstTask.addAll(resp);
      }, onError: (err) {
        isDataProcessing(false);
        showSnackBar("Error", err.toString(), Colors.red);
      });
    } catch (exception) {
      isDataProcessing(false);
      showSnackBar("Exception", exception.toString(), Colors.red);
    }
  }

  // common snack bar
  showSnackBar(String title, String message, Color backgroundColor) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: backgroundColor,
        colorText: Colors.white);
  }
}
