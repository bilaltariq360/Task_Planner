import 'package:flutter/material.dart';

import '../models/sub_tasks.dart';
import '../models/tasks.dart';

class TasksProvider with ChangeNotifier {
  List<Tasks> tasks = [];

  void addTask(String taskName, String taskTheme) {
    tasks.add(Tasks(taskName, taskTheme, DateTime.now()));
    notifyListeners();
  }

  void removeTask(String task) {
    for (var i = 0; i < tasks.length; i++) {
      if (tasks[i].taskHeading == task) {
        tasks.removeAt(i);
        break;
      }
    }
    notifyListeners();
  }

  void editTasks(int index, String heading, String imgPath) {
    tasks[index].taskHeading = heading;
    tasks[index].imagePath = imgPath;

    notifyListeners();
  }

  void addSubTask(
      String tasksHeading, String subTask, String desc, int pirority) {
    for (var task in tasks) {
      if (task.taskHeading == tasksHeading) {
        task.subTasks.add(
            SubTasks(task: subTask, descriptoin: desc, pirority: pirority));
        notifyListeners();
        return;
      }
    }
  }
}
