import 'package:get/get.dart';

import 'package:getx_todo_app_laravel/app/modules/home/task_model.dart';

class TaskProvider extends GetConnect {
  // Fetch Data
  Future<List<dynamic>> getTask(var page) async {
    try {
      final response = await get(
          "http://192.168.43.152:81/TodoApp/public/api/getTask?page=$page");
      if (response.status.hasError) {
        return Future.error(response.statusText);
      } else {
        return response.body['data'];
      }
    }
    catch(exception)
    {

      return Future.error(exception.toString());
    }
  }
}
