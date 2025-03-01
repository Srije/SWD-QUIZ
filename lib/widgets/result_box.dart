import 'package:flutter/material.dart';
import '../constants.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({
    Key? key,
    required this.result,
    required this.questionLength
  }) : super(key: key);

  final int result;
  final int questionLength;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: score,
      content: Padding(
          padding: const EdgeInsets.all(70.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          const Text('Result', style: TextStyle(color: Colors.black,fontSize: 30.0)),
        const SizedBox(height: 20.0,),
              CircleAvatar(radius: 70.0, backgroundColor: resultc, foregroundColor: Colors.black, child: Text('$result/$questionLength', style: TextStyle(fontSize: 35.0),),)
            ] ,
      ),
      ),
    );
  }
}
