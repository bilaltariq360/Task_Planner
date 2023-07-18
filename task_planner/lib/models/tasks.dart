import './sub_tasks.dart';

class Tasks {
  String taskHeading;
  String imagePath;
  DateTime createDate;
  List<SubTasks> subTasks = [];

  Tasks(this.taskHeading, this.imagePath, this.createDate);
}
