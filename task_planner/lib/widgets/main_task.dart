import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:task_planner/screens/add_sub_tasks.dart';
import 'package:task_planner/screens/edit_task.dart';

import '../providers/tasks_provider.dart';

class MainTask extends StatelessWidget {
  final String imagePath;
  final String heading;
  final bool moreOptions;
  int pirorityIndex = 1;
  MainTask(this.heading, this.imagePath, this.moreOptions, {super.key});

  final TextEditingController taskText = TextEditingController();
  final TextEditingController subTaskText = TextEditingController();
  final TextEditingController descText = TextEditingController();

  Future<void> showAlertBox(BuildContext context, TasksProvider tasks) async {
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

  @override
  Widget build(BuildContext context) {
    var tasks = Provider.of<TasksProvider>(context);
    return InkWell(
      onTap: () {
        if (moreOptions) {
          Navigator.pushNamed(context, AddSubTask.routeName,
              arguments: [heading, imagePath]);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.4,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        child: Text(
                          heading,
                          softWrap: true,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 38,
                              fontFamily: 'MavenPro'),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: (moreOptions)
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.center,
                      children: [
                        (moreOptions)
                            ? TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(53, 255, 255, 255),
                                  shape: const CircleBorder(),
                                ),
                                child: const Icon(
                                  Icons.more_horiz,
                                  size: 40,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: const Text('Select Option'),
                                      content: const Text(
                                          'Select an option to perform action'),
                                      actions: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 0, 20, 0),
                                          child: Align(
                                            alignment: Alignment
                                                .centerLeft, // Align the buttons to the left side
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  width: double.infinity,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 1.5,
                                                      color:
                                                          const Color.fromRGBO(
                                                              76, 175, 80, 1),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.pushNamed(
                                                          context,
                                                          EditTask.routeName,
                                                          arguments: heading);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.green[50],
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                      elevation: 0,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          CupertinoIcons.pen,
                                                          size: 28,
                                                          color:
                                                              Colors.green[500],
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Text(
                                                          'Edit',
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            color: Colors
                                                                .green[500],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  width: double.infinity,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 1.5,
                                                      color:
                                                          const Color.fromRGBO(
                                                              244, 67, 54, 1),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      showAlertBox(
                                                          context, tasks);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.red[50],
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                      elevation: 0,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          CupertinoIcons.delete,
                                                          size: 20,
                                                          color:
                                                              Colors.red[500],
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Text(
                                                          'Delete',
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            color:
                                                                Colors.red[500],
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
                                },
                              )
                            : const SizedBox(),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(53, 255, 255, 255),
                            shape: const CircleBorder(),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 40,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 30),
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.6,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            FittedBox(
                                              child: Text(
                                                'Add task to $heading',
                                                style: const TextStyle(
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 20),
                                              child: TextField(
                                                controller: subTaskText,
                                                cursorColor: Colors.black,
                                                decoration: InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    borderSide:
                                                        const BorderSide(
                                                            width: 1.5,
                                                            color:
                                                                Colors.black),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    borderSide:
                                                        const BorderSide(
                                                            width: 1.5,
                                                            color:
                                                                Colors.black),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  hintText: 'Task Name',
                                                  hintStyle: const TextStyle(
                                                      color: Colors.grey),
                                                  counterStyle: TextStyle(
                                                      color: Colors.red[700]),
                                                  prefixIcon: const Icon(
                                                      CupertinoIcons
                                                          .pencil_ellipsis_rectangle),
                                                ),
                                                autocorrect: true,
                                                maxLength: 20,
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 20),
                                              child: TextField(
                                                controller: descText,
                                                cursorColor: Colors.black,
                                                decoration: InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    borderSide:
                                                        const BorderSide(
                                                            width: 1.5,
                                                            color:
                                                                Colors.black),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    borderSide:
                                                        const BorderSide(
                                                            width: 1.5,
                                                            color:
                                                                Colors.black),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  hintText:
                                                      'Task Description (Optional)',
                                                  hintStyle: const TextStyle(
                                                      color: Colors.grey),
                                                  counterStyle: TextStyle(
                                                      color: Colors.red[700]),
                                                  prefixIcon: const Icon(
                                                      CupertinoIcons.news),
                                                ),
                                                autocorrect: true,
                                                maxLength: 100,
                                                maxLines: 3,
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Select Pirority',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    pirorityIndex =
                                                                        0;
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 40,
                                                                  height: 40,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            100),
                                                                    color: Colors
                                                                            .red[
                                                                        500],
                                                                  ),
                                                                ),
                                                              ),
                                                              (pirorityIndex ==
                                                                      0)
                                                                  ? const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Icon(
                                                                        CupertinoIcons
                                                                            .check_mark_circled_solid,
                                                                        color: Colors
                                                                            .white,
                                                                      ))
                                                                  : const SizedBox(),
                                                            ],
                                                          ),
                                                          SizedBox(height: 8),
                                                          Text(
                                                            'High',
                                                            style: TextStyle(
                                                                fontSize: 12),
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
                                                                    pirorityIndex =
                                                                        1;
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 40,
                                                                  height: 40,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            100),
                                                                    color: Colors
                                                                            .yellow[
                                                                        800],
                                                                  ),
                                                                ),
                                                              ),
                                                              (pirorityIndex ==
                                                                      1)
                                                                  ? const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Icon(
                                                                        CupertinoIcons
                                                                            .check_mark_circled_solid,
                                                                        color: Colors
                                                                            .white,
                                                                      ))
                                                                  : const SizedBox(),
                                                            ],
                                                          ),
                                                          SizedBox(height: 8),
                                                          Text(
                                                            'Medium',
                                                            style: TextStyle(
                                                                fontSize: 12),
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
                                                                    pirorityIndex =
                                                                        2;
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 40,
                                                                  height: 40,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            100),
                                                                    color: Colors
                                                                            .green[
                                                                        500],
                                                                  ),
                                                                ),
                                                              ),
                                                              (pirorityIndex ==
                                                                      2)
                                                                  ? const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Icon(
                                                                        CupertinoIcons
                                                                            .check_mark_circled_solid,
                                                                        color: Colors
                                                                            .white,
                                                                      ))
                                                                  : const SizedBox(),
                                                            ],
                                                          ),
                                                          SizedBox(height: 8),
                                                          Text(
                                                            'Low',
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 30),
                                              width: double.infinity,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: Colors.black,
                                              ),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  tasks.addSubTask(
                                                      heading,
                                                      subTaskText.text,
                                                      descText.text,
                                                      pirorityIndex);
                                                  Navigator.of(context).pop();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.black,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  elevation: 0,
                                                ),
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      CupertinoIcons
                                                          .plus_circle,
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
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
