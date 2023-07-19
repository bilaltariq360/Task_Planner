import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/sub_tasks.dart';
import '../models/tasks.dart';
import '../providers/tasks_provider.dart';
import '../widgets/main_task.dart';

class AddSubTask extends StatefulWidget {
  static String routeName = '/add-sub-task';
  const AddSubTask({super.key});

  @override
  State<AddSubTask> createState() => _AddSubTaskState();
}

class _AddSubTaskState extends State<AddSubTask> {
  List<SubTasks> subTasks = [];

  Future<void> showAlertBox(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              const Text('Warning'),
              const SizedBox(width: 10),
              Icon(
                CupertinoIcons.exclamationmark_triangle_fill,
                color: Colors.red[500],
              )
            ],
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this permanently?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> taskArgs =
        ModalRoute.of(context)!.settings.arguments as List<String>;
    var tasks = Provider.of<TasksProvider>(context);
    Tasks task;
    for (var i = 0; i < tasks.tasks.length; i++) {
      if (tasks.tasks[i].taskHeading == taskArgs[0]) {
        subTasks = tasks.tasks[i].subTasks;
        task = tasks.tasks[i];
      }
    }

    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 226, 226, 226),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(70),
            color: const Color.fromARGB(255, 250, 250, 250),
          ),
          margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 12),
          padding: const EdgeInsets.only(top: 50, bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: MainTask(taskArgs[0], taskArgs[1], false),
              ),
              Expanded(
                child: ReorderableListView(
                  children: [
                    for (final tile in subTasks)
                      Dismissible(
                        key: ValueKey(tile),
                        confirmDismiss: (DismissDirection direction) async {
                          if (direction == DismissDirection.endToStart) {
                            return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Row(
                                    children: [
                                      const Text('Warning'),
                                      const SizedBox(width: 10),
                                      Icon(
                                        CupertinoIcons
                                            .exclamationmark_triangle_fill,
                                        color: Colors.red[500],
                                      )
                                    ],
                                  ),
                                  content: const SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text(
                                            'Are you sure you want to delete this permanently?'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Delete'),
                                      onPressed: () {
                                        setState(() {
                                          subTasks.remove(tile);
                                        });
                                        Navigator.of(context).pop(true);
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else if (direction == DismissDirection.startToEnd) {
                            setState(() {
                              tile.completed = true;
                            });
                          }
                        },
                        background: Container(
                          color: Colors.green[500],
                          child: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  CupertinoIcons.check_mark,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Mark as done',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        secondaryBackground: Container(
                          color: Colors.red[500],
                          child: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  CupertinoIcons.delete,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Delete',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        child: ListTile(
                          key: ValueKey(tile),
                          leading: CircleAvatar(
                              radius: 8,
                              backgroundColor: (tile.pirority == 0)
                                  ? Colors.red[500]
                                  : ((tile.pirority == 1)
                                      ? Colors.yellow[800]
                                      : Colors.green)),
                          title: Text(
                            tile.task,
                            style: TextStyle(
                                fontSize: 20,
                                decoration: (tile.completed)
                                    ? TextDecoration.lineThrough
                                    : null),
                          ),
                          minVerticalPadding: 10,
                          /*trailing: Text(
                            DateFormat('jm').format(tile.creationTime),
                            style: const TextStyle(fontSize: 12),
                          ),*/
                          trailing: const Icon(
                            Icons.drag_indicator,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                  ],
                  onReorder: (oldIndex, newIndex) {
                    if (oldIndex < newIndex) newIndex--;
                    final temp = subTasks.removeAt(oldIndex);
                    setState(() {
                      subTasks.insert(newIndex, temp);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
