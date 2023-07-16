import 'package:flutter/material.dart';

class MainTask extends StatelessWidget {
  final String imagePath;

  const MainTask(this.imagePath, {super.key});

  @override
  Widget build(BuildContext context) {
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
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(right: 15, left: 15),
                      child: Text(
                        'Summer Holiday Plans',
                        softWrap: true,
                        style: TextStyle(
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
                        onPressed: () {},
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
