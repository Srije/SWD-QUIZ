import 'package:flutter/material.dart';
import 'package:swd_quiz/models/question_model.dart';
import './screens/home_screen.dart';
import 'package:swd_quiz/screens/start_page.dart';
import 'package:swd_quiz/models/db_connect.dart';

void main(){
  var db=DBconnect();

  // db.addQuestion(
  //     Question(id: '4', title: 'Find 3+6', options: {'7':false,'56':false,'9':true,'18':false})
  // );

  db.fetchQuestions();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

    @override
  Widget build(BuildContext context){
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: redirect()
      );
    }
}