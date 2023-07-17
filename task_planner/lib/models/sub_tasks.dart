class SubTasks {
  String task;
  String descriptoin;
  final DateTime creationTime = DateTime.now();
  DateTime? completedTime;
  DateTime? notification;
  bool completed;

  SubTasks({
    required this.task,
    required this.descriptoin,
    this.completed = false,
  });
}
