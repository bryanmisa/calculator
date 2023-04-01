import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter_math_utils/flutter_math_utils.dart';

import 'package:calculator/buttons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer = '';
  final List<String> buttons = [
    'C',
    'DEL',
    'CLR',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    '',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    alignment: Alignment.center,
                    child: Text(
                      userAnswer,
                      style: TextStyle(fontSize: 60),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userQuestion,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return Buttons(
                      buttonText: buttons[index],
                      color: Colors.green,
                      textColor: Colors.white,
                      buttonTapped: () {
                        setState(() {
                          userQuestion = '';
                        });
                      },
                    );
                  } else if (index == 1) {
                    return Buttons(
                      buttonText: buttons[index],
                      color: Colors.red,
                      textColor: Colors.white,
                      buttonTapped: () {
                        setState(() {
                          if (userQuestion.length > 0) {
                            userQuestion = userQuestion.substring(0, userQuestion.length - 1);
                          } else {
                            userQuestion = "";
                          }
                        });
                      },
                    );
                  } else if (index == 2) {
                    return Buttons(
                      buttonText: buttons[index],
                      color: Colors.orange,
                      textColor: Colors.white,
                      buttonTapped: () {
                        setState(() {
                          userQuestion = "";
                          userAnswer = "";
                        });
                      },
                    );
                  }

                  // Equal Button
                  else if (index == buttons.length - 1) {
                    return Buttons(
                      buttonText: buttons[index],
                      color: Colors.greenAccent,
                      textColor: Colors.white,
                      buttonTapped: () {
                        setState(() {
                          equalPressed();
                        });
                      },
                    );
                  }
                  // the rest of the buttons
                  else {
                    return Buttons(
                      buttonText: buttons[index],
                      color: isOperator(buttons[index])
                          ? Color.fromARGB(255, 149, 185, 246)
                          : Color.fromARGB(255, 178, 206, 255),
                      textColor: isOperator(buttons[index]) ? Colors.white : Colors.black38,
                      buttonTapped: () {
                        setState(() {
                          userQuestion += buttons[index];
                        });
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '+' || x == '-' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }
}
