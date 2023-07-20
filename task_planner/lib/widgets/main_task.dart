import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/add_sub_tasks.dart';

import '../providers/tasks_provider.dart';
import 'show_functions.dart';

class MainTask extends StatelessWidget {
  final String imagePath;
  final String heading;
  int pirorityIndex = 1;
  int total = 0;
  int completed = 0;
  MainTask(this.heading, this.imagePath, {super.key});

  final TextEditingController taskText = TextEditingController();
  final TextEditingController subTaskText = TextEditingController();
  final TextEditingController descText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var tasks = Provider.of<TasksProvider>(context);

    for (var i = 0; i < tasks.tasks.length; i++) {
      if (tasks.tasks[i].taskHeading == heading) {
        total = tasks.tasks[i].subTasks.length;
        completed = tasks.tasks[i].completedTasks.length;
      }
    }

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AddSubTask.routeName,
            arguments: [heading, imagePath]);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
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
                    children: [
                      Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            width: 30,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          Positioned(
                            top: (total != 0)
                                ? 100 - ((completed / total) * 100)
                                : ((completed > total)
                                    ? 0
                                    : 100), // Adjust this value to control the position of the second container
                            left: 20,
                            child: Container(
                              width: 30,
                              height: (total != 0)
                                  ? ((completed > total)
                                      ? 0
                                      : (completed / total) * 100)
                                  : 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '$completed/',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontFamily: 'MavenPro'),
                      ),
                      Text(
                        '$total',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontFamily: 'MavenPro'),
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        'tasks',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontFamily: 'MavenPro'),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
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
                            ShowFunctionsState.dialogBox(
                                context, heading, tasks);
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
                          onPressed: () {
                            ShowFunctionsState.bottomModalSheet(
                                context,
                                heading,
                                pirorityIndex,
                                tasks,
                                subTaskText,
                                descText);
                          },
                        ),
                      ],
                    ),
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
