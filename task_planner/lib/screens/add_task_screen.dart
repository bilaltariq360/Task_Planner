import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_planner/widgets/show_functions.dart';

import '../providers/tasks_provider.dart';
import '../services/notification_service.dart';

class AddTask extends StatefulWidget {
  static String routeName = '/add-task';
  AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController taskText = TextEditingController();
  int themeIndex = 0;
  String themePath = 'assets/images/random-bg.png';

  @override
  Widget build(BuildContext context) {
    var tasks = Provider.of<TasksProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
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
                    onPressed: () async {
                      if (taskText.text.isEmpty) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                            ShowFunctionsState.showSnackbarText(
                                'Enter Valid Project Name!'));
                      } else {
                        if (themeIndex == 0) {
                          themeIndex = Random().nextInt(8) + 1;
                        }
                        if (themeIndex == 1) {
                          themePath = 'assets/images/dark-purple-blue-bg.png';
                        } else if (themeIndex == 2) {
                          themePath = 'assets/images/blue-bg.png';
                        } else if (themeIndex == 3) {
                          themePath = 'assets/images/orange-bg.png';
                        } else if (themeIndex == 4) {
                          themePath = 'assets/images/purple-bg.png';
                        } else if (themeIndex == 5) {
                          themePath = 'assets/images/pattren-bg.png';
                        } else if (themeIndex == 6) {
                          themePath = 'assets/images/light-orange-bg.png';
                        } else if (themeIndex == 7) {
                          themePath = 'assets/images/gadgets-bg.png';
                        } else if (themeIndex == 8) {
                          themePath = 'assets/images/picachu-bg.png';
                        }
                        NotificationService.initializeNotification();
                        NotificationService.showNotification(
                          title: 'Task Planner',
                          body:
                              'New project ${taskText.text} added successfully!',
                        );
                        tasks.addTask(taskText.text, themePath);
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
              margin: const EdgeInsets.only(left: 20, top: 25),
              child: Text(
                'New Project',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.aspectRatio * 90,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 20),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black,
              ),
              child: Text(
                DateFormat('yMMMMEEEEd').format(DateTime.now()),
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.aspectRatio * 35,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 10),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black,
              ),
              child: Text(
                DateFormat('jm').format(DateTime.now()),
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.aspectRatio * 35,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 80),
              child: Text(
                'Select Theme',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.aspectRatio * 50,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.width * 0.2,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                themeIndex = 0;
                              });
                            },
                            child: Stack(
                              children: [
                                Image.asset('assets/images/random-bg.png'),
                                (themeIndex == 0)
                                    ? const Align(
                                        alignment: Alignment.center,
                                        child: Icon(
                                          CupertinoIcons
                                              .check_mark_circled_solid,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5, left: 5),
                      child: ClipRRect(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5, left: 5),
                      child: ClipRRect(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5, left: 5),
                      child: ClipRRect(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5, left: 5),
                      child: ClipRRect(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5, left: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.width * 0.2,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                themeIndex = 5;
                              });
                            },
                            child: Stack(
                              children: [
                                Image.asset('assets/images/pattren-bg.png'),
                                (themeIndex == 5)
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5, left: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.width * 0.2,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                themeIndex = 6;
                              });
                            },
                            child: Stack(
                              children: [
                                Image.asset(
                                    'assets/images/light-orange-bg.png'),
                                (themeIndex == 6)
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5, left: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.width * 0.2,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                themeIndex = 7;
                              });
                            },
                            child: Stack(
                              children: [
                                Image.asset('assets/images/gadgets-bg.png'),
                                (themeIndex == 7)
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.width * 0.2,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                themeIndex = 8;
                              });
                            },
                            child: Stack(
                              children: [
                                Image.asset('assets/images/picachu-bg.png'),
                                (themeIndex == 8)
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
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
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
                  hintText: 'Project Name',
                  hintStyle: const TextStyle(color: Colors.grey),
                  counterStyle: TextStyle(color: Colors.red[700]),
                  prefixIcon:
                      const Icon(CupertinoIcons.pencil_ellipsis_rectangle),
                ),
                autocorrect: true,
                maxLength: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
