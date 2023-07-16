import 'package:flutter/material.dart';

import './main_task.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 226, 226, 226),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Color.fromARGB(255, 250, 250, 250),
        ),
        margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 12),
        child: const SingleChildScrollView(
          child: Column(
            children: [
              /*Profile(),*/
              MainTask('assets/images/dark-purple-blue-bg.png'),
              MainTask('assets/images/orange-bg.png'),
              MainTask('assets/images/blue-bg.png'),
            ],
          ),
        ),
      ),
    );
  }
}
