import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../screens/add_task_screen.dart';
import '../providers/tasks_provider.dart';
import '../widgets/main_task.dart';
import '../widgets/profile.dart';

class Home extends StatelessWidget {
  static String routeName = '/home';
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var tasks = Provider.of<TasksProvider>(context);
    return Container(
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.bars,
                        size: 35,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AddTask.routeName);
                      },
                      icon: const Icon(
                        CupertinoIcons.add,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              const Profile(),
              ...tasks.tasks.map((task) {
                return MainTask(task.taskHeading, task.imagePath, true);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
