import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../providers/tasks_provider.dart';

class MainTask extends StatelessWidget {
  final String imagePath;
  final String heading;

  const MainTask(this.heading, this.imagePath, {super.key});

  @override
  Widget build(BuildContext context) {
    var tasks = Provider.of<TasksProvider>(context, listen: false);
    return Container(
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
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
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
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: Align(
                                    alignment: Alignment
                                        .centerLeft, // Align the buttons to the left side
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          width: double.infinity,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1.5,
                                              color: const Color.fromRGBO(
                                                  76, 175, 80, 1),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green[50],
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              elevation: 0,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  CupertinoIcons.pen,
                                                  size: 28,
                                                  color: Colors.green[500],
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  'Edit',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.green[500],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          width: double.infinity,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1.5,
                                              color: const Color.fromRGBO(
                                                  244, 67, 54, 1),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              tasks.removeTask(heading);
                                              Navigator.of(context).pop();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red[50],
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              elevation: 0,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  CupertinoIcons.delete,
                                                  size: 20,
                                                  color: Colors.red[500],
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.red[500],
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
                      ),
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
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
