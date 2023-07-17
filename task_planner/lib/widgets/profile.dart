import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tasks_provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, Bilal',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.aspectRatio * 50,
                    fontWeight: FontWeight.w600,
                    height: 2.5),
              ),
              Text(
                'Your',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.aspectRatio * 90,
                    fontWeight: FontWeight.w800,
                    height: 1.1),
              ),
              Row(
                children: [
                  Text(
                    'Projects ',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.aspectRatio * 90,
                        fontWeight: FontWeight.w800,
                        height: 1.1),
                  ),
                  Text(
                    '(${Provider.of<TasksProvider>(context).tasks.length})',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.aspectRatio * 60,
                        height: 1.1),
                  ),
                ],
              ),
            ],
          ),
          CircleAvatar(
            radius: MediaQuery.of(context).size.aspectRatio * 60,
            child: Image.asset(
              'assets/images/Bilal-Tariq.png',
              //width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      ),
    );
  }
}
