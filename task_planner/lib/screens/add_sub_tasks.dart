import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/sub_tasks.dart';
import '../models/tasks.dart';
import '../providers/tasks_provider.dart';
import '../widgets/show_functions.dart';

class AddSubTask extends StatefulWidget {
  static String routeName = '/add-sub-task';
  const AddSubTask({super.key});

  @override
  State<AddSubTask> createState() => _AddSubTaskState();
}

class _AddSubTaskState extends State<AddSubTask> {
  List<SubTasks> subTasks = [];
  int pirorityIndex = 1;
  TextEditingController subTaskText = TextEditingController();
  TextEditingController descText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> taskArgs =
        ModalRoute.of(context)!.settings.arguments as List<String>;
    var tasks = Provider.of<TasksProvider>(context);
    Tasks? task;
    for (var i = 0; i < tasks.tasks.length; i++) {
      if (tasks.tasks[i].taskHeading == taskArgs[0]) {
        subTasks = tasks.tasks[i].subTasks;
        task = tasks.tasks[i];
      }
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              height: MediaQuery.of(context).size.aspectRatio + 180,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    taskArgs[1],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: FittedBox(
                      child: Text(
                        task!.taskHeading,
                        softWrap: true,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontFamily: 'MavenPro'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tasks',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(53, 255, 255, 255),
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    ShowFunctionsState.bottomModalSheet(
                        context,
                        task!.taskHeading,
                        pirorityIndex,
                        tasks,
                        subTaskText,
                        descText);
                  },
                ),
              ],
            ),
          ),
          (subTasks.isEmpty && task!.completedTasks.isEmpty)
              ? Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Icon(
                        CupertinoIcons.exclamationmark_circle,
                        size: 80,
                        color: Colors.red[500],
                      ),
                      const SizedBox(height: 10),
                      FittedBox(
                        child: Text(
                          'No Tasks available',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.red[500],
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Expanded(
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
                            } else if (direction ==
                                DismissDirection.startToEnd) {
                              setState(() {
                                tile.completed = true;
                                task!.addToCompleted(tile);
                                subTasks.remove(tile);
                              });
                            }
                          },
                          background: Container(
                            color: Colors.green[500],
                            child: const Padding(
                              padding: EdgeInsets.only(left: 15),
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
                              padding: EdgeInsets.only(right: 15),
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
                                  fontSize: 16,
                                  decoration: (tile.completed)
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color: (tile.completed)
                                      ? Colors.grey
                                      : Colors.black),
                            ),
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
          (task!.completedTasks.isEmpty)
              ? const SizedBox()
              : const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Completed Tasks',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                ),
          Expanded(
            child: ListView(
              children: [
                for (final tile in task!.completedTasks)
                  Dismissible(
                    key: ValueKey(tile),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (DismissDirection direction) async {
                      return await showDialog(
                        context: context,
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
                                    task!.completedTasks.remove(tile);
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
                    },
                    background: Container(
                      color: Colors.red[500],
                      child: const Padding(
                        padding: EdgeInsets.only(right: 15),
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
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
                              ? const Color.fromRGBO(244, 67, 54, 0.5)
                              : ((tile.pirority == 1)
                                  ? const Color.fromRGBO(249, 168, 37, 0.5)
                                  : const Color.fromRGBO(76, 175, 80, 0.5))),
                      title: Text(
                        tile.task,
                        style: TextStyle(
                            fontSize: 16,
                            decoration: (tile.completed)
                                ? TextDecoration.lineThrough
                                : null,
                            color:
                                (tile.completed) ? Colors.grey : Colors.black),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
