import 'package:flutter/material.dart';

import '../models/tasks.dart';

class TasksProvider with ChangeNotifier {
  List<Tasks> tasks = [];

  void addTask(String taskName, String taskTheme) {
    tasks.add(Tasks(taskName, taskTheme));
    notifyListeners();
  }

  void removeTask(String task) {
    for (var i = 0; i < tasks.length; i++) {
      if (tasks[i].taskHeading == task) {
        tasks.removeAt(i);
      }
    }
    notifyListeners();
  }
}
