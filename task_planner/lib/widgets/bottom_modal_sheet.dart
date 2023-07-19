import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../providers/tasks_provider.dart';

class BottomModalSheet {
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
                          const SizedBox(
                            height: 30,
                          ),
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
                          tasks.addSubTask(heading, subTaskText.text,
                              descText.text, pirorityIndex);
                          Navigator.of(context).pop();
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
  }
}
