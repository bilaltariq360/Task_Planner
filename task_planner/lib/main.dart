import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/tasks_provider.dart';
import './screens/home_screen.dart';
import './screens/add_task_screen.dart';
import './screens/edit_task.dart';
import './screens/add_sub_tasks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => TasksProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Planner',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          fontFamily: 'NotoSans',
          useMaterial3: true,
        ),
        home: const Scaffold(
          body: Home(),
          drawer: Drawer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.settings,
                            size: 30,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Profile Settings',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Divider(thickness: 2),
                      SizedBox(height: 20),
                      InkWell(
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(
                              CupertinoIcons.pen,
                              size: 22,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Edit Name',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      InkWell(
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(
                              CupertinoIcons.person_alt_circle,
                              size: 22,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Edit Picture',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      InkWell(
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(
                              CupertinoIcons.info_circle,
                              size: 22,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'About Developer',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: [
                      Divider(thickness: 2),
                      Text(
                        'Developed by Bilal Tariq with ❤️',
                        style: TextStyle(fontSize: 13),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        routes: {
          AddTask.routeName: (context) => AddTask(),
          EditTask.routeName: (context) => EditTask(),
          AddSubTask.routeName: (context) => const AddSubTask(),
        },
      ),
    );
  }
}
