import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo_app_laravel/app/modules/home/controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isDataProcessing.value == true) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (controller.lstTask.length > 0) {
            return Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Active Task : ${controller.lstTask[0]['active_task']}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.green,
                              child: Text(
                                'H',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              radius: 30,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              '${controller.lstTask[0]['highest_priority']}',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.deepOrange,
                              child: Text(
                                'M',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              radius: 30,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              '${controller.lstTask[0]['medium_priority']}',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.purple,
                              child: Text(
                                'L',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              radius: 30,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              '${controller.lstTask[0]['lowest_priority']}',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.lstTask.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == controller.lstTask.length - 1 &&
                            controller.isMoreDataAvailable.value == true) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: controller.lstTask[index]
                                                ['task_priority'] ==
                                            1
                                        ? Colors.green
                                        : (controller.lstTask[index]
                                                    ['task_priority'] ==
                                                2
                                            ? Colors.deepOrange
                                            : Colors.purple),
                                    child: Text(
                                      controller.lstTask[index]
                                                  ['task_priority'] ==
                                              1
                                          ? 'H'
                                          : (controller.lstTask[index]
                                                      ['task_priority'] ==
                                                  2
                                              ? 'M'
                                              : 'L'),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.lstTask[index]['task_name'],
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                          controller.lstTask[index]
                                              ['task_description'],
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600])),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.green,
                                        ),
                                        onTap: () {  displayEditTaskWindow(
                                            controller.lstTask[index]
                                            ['task_id'],
                                            controller.titleEditingController
                                                .text =
                                            controller.lstTask[index]
                                            ['task_name'],
                                            controller
                                                .descriptionEditingController
                                                .text = controller
                                                .lstTask[index]
                                            ['task_description'],
                                            controller.selectedPriority.value =
                                            controller.lstTask[index]
                                            ['task_priority']);},
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      GestureDetector(
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onTap: () {displayDeleteDialog(controller
                                            .lstTask[index]['task_id']);},
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ));
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                'Data not found',
                style: TextStyle(fontSize: 25),
              ),
            );
          }
        }
      }),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Add Task'),
        icon: Icon(Icons.add),
        onPressed: () {
          displayAddTaskWindow();
        },
      ),
    );
  }

  void displayAddTaskWindow() {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
          color: Colors.white,
        ),
        child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Task',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                        hintText: 'Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      controller: controller.titleEditingController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      controller: controller.descriptionEditingController,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Obx(() => DropdownButton<String>(
                          // Set the Items of DropDownButton
                          items: [
                            DropdownMenuItem(
                              value: "1",
                              child: Text(
                                "High Priority",
                              ),
                            ),
                            DropdownMenuItem(
                              value: "2",
                              child: Text(
                                "Medium Priority",
                              ),
                            ),
                            DropdownMenuItem(
                              value: "3",
                              child: Text(
                                "Low Priority",
                              ),
                            ),
                          ],
                          value: controller.selectedPriority.value.toString(),
                          hint: Text('Select Task Priority'),
                          isExpanded: true,
                          onChanged: (selectedValue) {
                            controller.selectedPriority.value =
                                int.parse(selectedValue);
                          },
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(() {
                          return RaisedButton(
                            child: Text(
                                controller.isProcessing.value == true
                                    ? 'Processing'
                                    : 'Save'),
                            onPressed: () {
                              if (controller.isProcessing.value == false) {
                                saveTask(
                                    controller.titleEditingController.text,
                                    controller
                                        .descriptionEditingController.text,
                                    controller.selectedPriority.value);
                              }
                            },
                          );
                        })
                      ],
                    )
                  ],
                ),
              ],
            )),

      ),
    );
  }

  void saveTask(String title, String description, int priority) {
    controller.saveTask(
        {'title': title, 'description': description, 'priority': priority});
    Get.back();
  }


  void displayEditTaskWindow(
      int id, String title, String description, int priority) {
    Get.bottomSheet(
      Container(
        child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Edit Task',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                        hintText: 'Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      controller: controller.titleEditingController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      controller: controller.descriptionEditingController,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Obx(() => DropdownButton<String>(
                      // Set the Items of DropDownButton
                      items: [
                        DropdownMenuItem(
                          value: "1",
                          child: Text(
                            "High Priority",
                          ),
                        ),
                        DropdownMenuItem(
                          value: "2",
                          child: Text(
                            "Medium Priority",
                          ),
                        ),
                        DropdownMenuItem(
                          value: "3",
                          child: Text(
                            "Low Priority",
                          ),
                        ),
                      ],
                      value: controller.selectedPriority.value.toString(),
                      hint: Text('Select Task Priority'),
                      isExpanded: true,
                      onChanged: (selectedValue) {
                        controller.selectedPriority.value =
                            int.parse(selectedValue);
                      },
                    )),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(() {
                          return RaisedButton(
                            child: Text(
                                controller.isDataProcessing.value == true
                                    ? 'Processing'
                                    : 'Update'),
                            onPressed: () {
                              if (controller.isDataProcessing.value == false) {
                                updateTask(
                                    id,
                                    controller.titleEditingController.text,
                                    controller
                                        .descriptionEditingController.text,
                                    controller.selectedPriority.value);
                              }
                            },
                          );
                        })
                      ],
                    )
                  ],
                ),
              ],
            )),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
            color: Colors.white),
      ),
    );
  }

  void updateTask(int id, String title, String description, int priority) {
    controller.updateTask({
      'id': id,
      'title': title,
      'description': description,
      'priority': priority
    });
    Get.back();
  }

  displayDeleteDialog(int id) {
    Get.defaultDialog(
      title: "Delete Task",
      titleStyle: TextStyle(fontSize: 20),
      middleText: 'Are you sure to delete task ?',
      textCancel: "Cancel",
      textConfirm: "Confirm",
      confirmTextColor: Colors.white,
      onCancel: () {},
      onConfirm: () {
        controller.deleteTask({'id':id});
        Get.back();
      },
    );
  }
}
