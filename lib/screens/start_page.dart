import 'package:flutter/material.dart';
import 'package:swd_quiz/constants.dart';
import 'home_screen.dart';

class redirect extends StatelessWidget {
  const redirect({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text('SWD Nucleus QUIZ'),backgroundColor: background, shadowColor: Colors.transparent,
      ),

      body: Center(
        child:

        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HomeScreen()));
            },
            child: Text('Start Quiz'),),

      ),

    );
  }
}