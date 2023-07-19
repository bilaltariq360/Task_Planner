import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../providers/tasks_provider.dart';
import '../screens/edit_task.dart';
import '../services/notification_service.dart';

class ShowFunctions extends StatefulWidget {
  const ShowFunctions({super.key});

  @override
  State<ShowFunctions> createState() => ShowFunctionsState();
}

class ShowFunctionsState extends State<ShowFunctions> {
  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }

  static DateTime? dateTime;

  static SnackBar showSnackbarText(String label) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        label,
        style: const TextStyle(fontSize: 15),
      ),
      duration: const Duration(milliseconds: 1500),
      action: SnackBarAction(
        label: 'Ok',
        textColor: Colors.red[400],
        onPressed: () {},
      ),
    );
  }

  static Future<void> showAlertBox(
      BuildContext context, String heading, TasksProvider tasks) async {
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
                tasks.removeTask(heading);
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

  static void dialogBox(
      BuildContext context, String heading, TasksProvider tasks) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Select Option'),
        content: const Text('Select an option to perform action'),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Align(
              alignment:
                  Alignment.centerLeft, // Align the buttons to the left side
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.pushNamed(context, EditTask.routeName,
                            arguments: heading);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[500],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        elevation: 0,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.pen,
                            size: 28,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Edit',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        showAlertBox(context, heading, tasks);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[500],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        elevation: 0,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.delete,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Delete',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void bottomModalSheet(
    BuildContext context,
    String heading,
    int pirorityIndex,
    TasksProvider tasks,
    TextEditingController subTaskText,
    TextEditingController descText,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FittedBox(
                      child: Text(
                        'Add task to $heading',
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w800),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: TextField(
                        controller: subTaskText,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                width: 1.5, color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                width: 1.5, color: Colors.black),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: 'Task Name',
                          hintStyle: const TextStyle(color: Colors.grey),
                          counterStyle: TextStyle(color: Colors.red[700]),
                          prefixIcon: const Icon(
                              CupertinoIcons.pencil_ellipsis_rectangle),
                        ),
                        autocorrect: true,
                        maxLength: 20,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: TextField(
                        controller: descText,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                width: 1.5, color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                width: 1.5, color: Colors.black),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: 'Task Description (Optional)',
                          hintStyle: const TextStyle(color: Colors.grey),
                          counterStyle: TextStyle(color: Colors.red[700]),
                          prefixIcon: const Icon(CupertinoIcons.news),
                        ),
                        autocorrect: true,
                        maxLength: 100,
                        maxLines: 3,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Add Reminder',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w800),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  //padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          width: 1, color: Colors.black)),
                                  child: IconButton(
                                    onPressed: () async {
                                      final DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        initialDatePickerMode:
                                            DatePickerMode.day,
                                        firstDate: DateTime(2023),
                                        lastDate: DateTime(2025),
                                      );

                                      if (pickedDate != null) {
                                        final TimeOfDay? pickedTime =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        );

                                        if (pickedTime != null) {
                                          DateTime selectedDateTime = DateTime(
                                            pickedDate.year,
                                            pickedDate.month,
                                            pickedDate.day,
                                            pickedTime.hour,
                                            pickedTime.minute,
                                          );
                                          setState(() {
                                            dateTime = selectedDateTime;
                                          });
                                        }
                                      }
                                      ;
                                    },
                                    icon: const Icon(
                                      Icons.alarm_add,
                                      size: 25,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                (dateTime != null)
                                    ? Container(
                                        margin: const EdgeInsets.only(
                                            left: 10, top: 20),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 25),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.black,
                                        ),
                                        child: Text(
                                          DateFormat('yMMMMEEEEd')
                                              .format(dateTime!),
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .aspectRatio *
                                                  35,
                                              color: Colors.white),
                                        ),
                                      )
                                    : const SizedBox(),
                                (dateTime != null)
                                    ? Container(
                                        margin: const EdgeInsets.only(
                                            left: 10, top: 20),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 25),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.black,
                                        ),
                                        child: Text(
                                          DateFormat('jm').format(dateTime!),
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .aspectRatio *
                                                  35,
                                              color: Colors.white),
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Select Pirority',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            pirorityIndex = 0;
                                          });
                                        },
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.red[500],
                                          ),
                                        ),
                                      ),
                                      (pirorityIndex == 0)
                                          ? const Align(
                                              alignment: Alignment.center,
                                              child: Icon(
                                                CupertinoIcons
                                                    .check_mark_circled_solid,
                                                color: Colors.white,
                                              ))
                                          : const SizedBox(),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'High',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            pirorityIndex = 1;
                                          });
                                        },
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.yellow[800],
                                          ),
                                        ),
                                      ),
                                      (pirorityIndex == 1)
                                          ? const Align(
                                              alignment: Alignment.center,
                                              child: Icon(
                                                CupertinoIcons
                                                    .check_mark_circled_solid,
                                                color: Colors.white,
                                              ))
                                          : const SizedBox(),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Medium',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            pirorityIndex = 2;
                                          });
                                        },
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.green[500],
                                          ),
                                        ),
                                      ),
                                      (pirorityIndex == 2)
                                          ? const Align(
                                              alignment: Alignment.center,
                                              child: Icon(
                                                CupertinoIcons
                                                    .check_mark_circled_solid,
                                                color: Colors.white,
                                              ))
                                          : const SizedBox(),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Low',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.black,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (subTaskText.text.isEmpty) {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                                showSnackbarText('Enter Valid Task Name!'));
                          } else {
                            tasks.addSubTask(heading, subTaskText.text,
                                descText.text, pirorityIndex);
                            Navigator.of(context).pop();
                            NotificationService.initializeNotification();
                            NotificationService.showNotification(
                                title: 'Task Planner',
                                body:
                                    'New task successfully added to project $heading!');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          elevation: 0,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.plus_circle,
                              size: 20,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Done',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
    ShowFunctionsState.dateTime = null;
  }
}
