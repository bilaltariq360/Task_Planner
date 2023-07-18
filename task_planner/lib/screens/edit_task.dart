import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/tasks.dart';
import '../providers/tasks_provider.dart';

class EditTask extends StatefulWidget {
  static String routeName = '/edit-task';
  Tasks? editedTask;
  bool firstTimeCheck = false;
  var i = 0;
  EditTask({super.key});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TextEditingController taskText = TextEditingController();
  int themeIndex = 1;
  String themePath = 'assets/images/dark-purple-blue-bg.png';

  SnackBar showSnackbarText(String label) {
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

  @override
  Widget build(BuildContext context) {
    String taskKey = ModalRoute.of(context)!.settings.arguments as String;
    var tasks = Provider.of<TasksProvider>(context);

    if (widget.firstTimeCheck == false) {
      for (widget.i = 0; widget.i < tasks.tasks.length; widget.i++) {
        if (taskKey == tasks.tasks[widget.i].taskHeading) {
          widget.editedTask = tasks.tasks[widget.i];
          taskText.text = tasks.tasks[widget.i].taskHeading;
          themePath = tasks.tasks[widget.i].imagePath;

          if (themePath == 'assets/images/dark-purple-blue-bg.png') {
            themeIndex = 1;
          } else if (themePath == 'assets/images/blue-bg.png') {
            themeIndex = 2;
          } else if (themePath == 'assets/images/orange-bg.png') {
            themeIndex = 3;
          } else if (themePath == 'assets/images/purple-bg.png') {
            themeIndex = 4;
          }

          break;
        }
      }
      widget.firstTimeCheck = true;
    }
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color.fromARGB(255, 226, 226, 226),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(70),
            color: const Color.fromARGB(255, 250, 250, 250),
          ),
          margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 12),
          padding: const EdgeInsets.only(top: 30, bottom: 50),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20, left: 20),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          CupertinoIcons.clear,
                          size: 35,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20, right: 20),
                      child: IconButton(
                        onPressed: () {
                          if (taskText.text.isEmpty) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                                showSnackbarText('Enter Valid Task Name!'));
                          } else {
                            if (themeIndex == 1) {
                              themePath =
                                  'assets/images/dark-purple-blue-bg.png';
                            } else if (themeIndex == 2) {
                              themePath = 'assets/images/blue-bg.png';
                            } else if (themeIndex == 3) {
                              themePath = 'assets/images/orange-bg.png';
                            } else if (themeIndex == 4) {
                              themePath = 'assets/images/purple-bg.png';
                            }
                            tasks.editTasks(widget.i, taskText.text, themePath);
                            Navigator.of(context).pop();
                          }
                        },
                        icon: const Icon(
                          CupertinoIcons.check_mark,
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 25),
                  child: Text(
                    'Edit Task',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.aspectRatio * 90,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 20),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black,
                  ),
                  child: Text(
                    DateFormat('yMMMMEEEEd')
                        .format(tasks.tasks[widget.i].createDate),
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.aspectRatio * 35,
                        color: Colors.white),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black,
                  ),
                  child: Text(
                    DateFormat('jm').format(tasks.tasks[widget.i].createDate),
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.aspectRatio * 35,
                        color: Colors.white),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 10),
                  //padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 1, color: Colors.black)),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.bell_slash,
                      size: 25,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 30),
                  child: Text(
                    'Select Theme',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.aspectRatio * 50,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.width * 0.2,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                themeIndex = 1;
                              });
                            },
                            child: Stack(
                              children: [
                                Image.asset(
                                    'assets/images/dark-purple-blue-bg.png'),
                                (themeIndex == 1)
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
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.width * 0.2,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                themeIndex = 2;
                              });
                            },
                            child: Stack(
                              children: [
                                Image.asset('assets/images/blue-bg.png'),
                                (themeIndex == 2)
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
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.width * 0.2,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                themeIndex = 3;
                              });
                            },
                            child: Stack(
                              children: [
                                Image.asset('assets/images/orange-bg.png'),
                                (themeIndex == 3)
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
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.width * 0.2,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                themeIndex = 4;
                              });
                            },
                            child: Stack(
                              children: [
                                Image.asset('assets/images/purple-bg.png'),
                                (themeIndex == 4)
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 30),
                  child: TextField(
                    controller: taskText,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(width: 1.5, color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(width: 1.5, color: Colors.black),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'Task Name',
                      hintStyle: const TextStyle(color: Colors.grey),
                      counterStyle: TextStyle(color: Colors.red[700]),
                      prefixIcon:
                          const Icon(CupertinoIcons.pencil_ellipsis_rectangle),
                    ),
                    autocorrect: true,
                    maxLength: 20,
                  ),
                ),
                /*Container(
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: TextField(
                    controller: descText,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(width: 1.5, color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(width: 1.5, color: Colors.black),
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
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
