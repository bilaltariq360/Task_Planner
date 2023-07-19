import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/add_sub_tasks.dart';

import '../providers/tasks_provider.dart';
import 'show_functions.dart';

class MainTask extends StatelessWidget {
  final String imagePath;
  final String heading;
  final bool moreOptions;
  int pirorityIndex = 1;
  MainTask(this.heading, this.imagePath, this.moreOptions, {super.key});

  final TextEditingController taskText = TextEditingController();
  final TextEditingController subTaskText = TextEditingController();
  final TextEditingController descText = TextEditingController();

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
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
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
                                  ShowFunctions.dialogBox(
                                      context, heading, tasks);
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
                            ShowFunctions.bottomModalSheet(context, heading,
                                pirorityIndex, tasks, subTaskText, descText);
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
