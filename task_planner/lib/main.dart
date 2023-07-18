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
        ),
        routes: {
          AddTask.routeName: (context) => AddTask(),
          EditTask.routeName: (context) => EditTask(),
          AddSubTask.routeName: (context) => AddSubTask(),
        },
      ),
    );
  }
}
