import './sub_tasks.dart';

class Tasks {
  String taskHeading;
  String imagePath;
  DateTime createDate;
  List<SubTasks> subTasks = [];
  List<SubTasks> completedTasks = [];

  Tasks(this.taskHeading, this.imagePath, this.createDate);

  void addToCompleted(SubTasks completedTask) {
    completedTasks.add(completedTask);
  }
}
