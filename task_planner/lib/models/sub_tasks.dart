class SubTasks {
  String task;
  String descriptoin;
  final DateTime creationTime = DateTime.now();
  DateTime? completedTime;
  DateTime? notification;
  final int pirority;
  bool completed = false;

  SubTasks({
    required this.task,
    required this.descriptoin,
    required this.pirority,
    DateTime? notification,
  });
}
