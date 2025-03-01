import 'package:flutter/material.dart';
import 'package:swd_quiz/widgets/option_card.dart';
import '../constants.dart';
import '../models/question_model.dart';
import '../widgets/question_widget.dart';
import '../widgets/next_button.dart';
import '../widgets/result_box.dart';
import '../models/db_connect.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
    _HomeScreenState createState() => _HomeScreenState();
  }
  class _HomeScreenState extends State<HomeScreen>{
  var db=DBconnect();
  late Future _questions;

  // List<Question> _questions = [
  //   Question(
  //     id:'1',
  //     title: 'What is 2+2?',
  //     options: {'10':false,'5':false,'18':false,'4':true},
  //   ),
  //   Question(
  //     id:'2',
  //     title: 'What is 10+20?',
  //     options: {'10':false,'30':true,'85':false,'15':false},
  //   )
  // ];

  Future<List<Question>> getData()async{
    return db.fetchQuestions();
  }

  @override
  void initState(){
    _questions = getData();
    super.initState();
  }

  int index =0;
  int score =0;
  bool isPressed =false;
  bool isAlreadySelected = false;

  void nextQuestion(int questionLength){
    if(index==questionLength-1){
      showDialog(context: context,barrierDismissible: false, builder: (ctx) => ResultBox(result: score, questionLength: questionLength,));
    }
    else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelected = false;
        });
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Please choose an option to go to the next question'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(vertical: 24.0),));
      }
    }
  }

  void checkAnswerAndUpdate(bool value){
    if(isAlreadySelected){
      return;
    }
    else {
      isAlreadySelected=true;
      if (value == true) {
        score++;}
        setState(() {
          isPressed = true;
        });

    }
  }

  @override
    Widget build(BuildContext context){
      return FutureBuilder(
        future: _questions as Future<List<Question>>,
        builder: (ctx,snapshot){
          if(snapshot.connectionState==ConnectionState.done){
            if(snapshot.hasError){
              return Center(child: Text('${snapshot.error}'),);
            }
            else if(snapshot.hasData){
              var extractedData = snapshot.data as List<Question>;
              return Scaffold(
                backgroundColor: background,
                appBar: AppBar(
                  title: const Text('Quiz'),
                  backgroundColor: background,
                  shadowColor: Colors.transparent,
                  actions: [
                    Padding(padding: const EdgeInsets.all(18.0),child: Text('Score: $score',style: const TextStyle(fontSize: 18.0),),),
                  ],
                ),
                body: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      QuestionWidget(
                        indexAction: index,
                        question: extractedData[index].title,
                        totalQuestions: extractedData.length,
                      ),
                      const Divider(color: neutral),
                      const SizedBox(height: 25.0),
                      for(int i =0; i<extractedData[index].options.length;i++)
                        GestureDetector(
                          onTap: () => checkAnswerAndUpdate(extractedData[index].options.values.toList()[i]),
                          child: OptionCard(
                            option: extractedData[index].options.keys.toList()[i],
                            color: isPressed ?extractedData[index].options.values.toList()[i] == true? correct : incorrect : neutral,
                          ),
                        ),
                    ],
                  ),

                ),
                floatingActionButton: GestureDetector(
                  onTap: () => nextQuestion(extractedData.length),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: NextButton(
                    ),
                  ),
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

              );
            }
          }
          else{
            return const Center(child: CircularProgressIndicator());
          }
          return const Center(
            child: Text('No Data'),
          );
        },

      );
  }
}