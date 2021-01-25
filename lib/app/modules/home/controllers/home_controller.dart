import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_app_laravel/app/modules/home/providers/task_provider.dart';

class HomeController extends GetxController {
  var lstTask = List<dynamic>.empty(growable: true).obs;
  var page = 1;
  var isDataProcessing = false.obs;

  // For Pagination
  ScrollController scrollController = ScrollController();
  var isMoreDataAvailable = true.obs;

  // To Save Task
  TextEditingController titleEditingController, descriptionEditingController;
  var selectedPriority = 1.obs;
  var isProcessing = false.obs;

  @override
  void onInit() async {
    super.onInit();
    // Fetch Data
    getTask(page);

    //For Pagination
    paginateTask();

    // To Save  Task
    titleEditingController = TextEditingController();
    descriptionEditingController = TextEditingController();
  }

  // Fetch Data
  void getTask(var page) {
    try {
      isMoreDataAvailable(false);
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

  // For Pagination
  void paginateTask() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print("reached end");
        page++;
        getMoreTask(page);
      }
    });
  }

  // Get More data
  void getMoreTask(var page) {
    try {
      TaskProvider().getTask(page).then((resp) {
        if (resp.length > 0) {
          isMoreDataAvailable(true);
        } else {
          isMoreDataAvailable(false);
          showSnackBar("Message", "No more items", Colors.lightBlueAccent);
        }
        lstTask.addAll(resp);
      }, onError: (err) {
        isMoreDataAvailable(false);
        showSnackBar("Error", err.toString(), Colors.red);
      });
    } catch (exception) {
      isMoreDataAvailable(false);
      showSnackBar("Exception", exception.toString(), Colors.red);
    }
  }

  // Refresh List
  void refreshList() async {
    page = 1;
    getTask(page);
  }

  // Save Data
  void saveTask(Map data) {
    try {
      isProcessing(true);
      TaskProvider().saveTask(data).then((resp) {
        if (resp == "success") {
          clearTextEditingControllers();
          isProcessing(false);

          showSnackBar("Add Task", "Task Added", Colors.green);
          lstTask.clear();
          refreshList();
        } else {
          showSnackBar("Add Task", "Failed to Add Task", Colors.red);
        }
      }, onError: (err) {
        isProcessing(false);
        showSnackBar("Error", err.toString(), Colors.red);
      });
    } catch (exception) {
      isProcessing(false);
      showSnackBar("Exception", exception.toString(), Colors.red);
    }
  }
  // Update Data
  void updateTask(Map data) {
    try {
      isProcessing(true);
      TaskProvider().updateTask(data).then((resp) {
        if(resp=="success") {
          clearTextEditingControllers();
          isProcessing(false);

          showSnackBar("Edit Task", "Task Updated", Colors.green);
          lstTask.clear();
          refreshList();
        }
        else
          {
            showSnackBar("Edit Task", "Task not Updated", Colors.red);
          }
      }, onError: (err) {
        isProcessing(false);
        showSnackBar("Error", err.toString(), Colors.red);
      });
    } catch (exception) {
      isProcessing(false);
      showSnackBar("Exception", exception.toString(), Colors.red);
    }
  }

  // Delete Data
  void deleteTask(Map data) {
    try {
      isProcessing(true);
      TaskProvider().deleteTask(data).then((resp) {
        isProcessing(false);
        if(resp=="success") {
          showSnackBar("Delete Task", "Task Deleted", Colors.green);
          lstTask.clear();
          refreshList();
        }
        else
        {
          showSnackBar("Delete Task", "Task not Deleted", Colors.red);
        }
      }, onError: (err) {
        isProcessing(false);
        showSnackBar("Error", err.toString(), Colors.red);
      });
    } catch (exception) {
      isProcessing(false);
      showSnackBar("Exception", exception.toString(), Colors.red);
    }
  }
  // clear the controllers
  void clearTextEditingControllers() {
    titleEditingController.clear();
    descriptionEditingController.clear();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    scrollController.dispose();
    titleEditingController.dispose();
    descriptionEditingController.dispose();
  }
}
