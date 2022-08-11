import 'package:flutter/material.dart';

import 'package:math_expressions/math_expressions.dart';

import 'package:ios_calculator/widgets/custom_text_button.dart';

class IosCalculator extends StatefulWidget {
  const IosCalculator({Key? key}) : super(key: key);

  @override
  State<IosCalculator> createState() => _IosCalculatorState();
}

class _IosCalculatorState extends State<IosCalculator> {

  //button list
  final List<String> buttons = [
    'AC',
    'DEL',
    '%',
    '÷',
    '7',
    '8',
    '9',
    '×',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  //Logic
  String equation = '';
  String result = '';

  void equalPressed() {
    String finalEquation = equation;
    finalEquation = finalEquation.replaceAll('÷', '/');
    finalEquation = finalEquation.replaceAll('×', '*');

    //package code
    Parser p = Parser();
    Expression exp = p.parse(finalEquation);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    result = eval.toString();
  }

  //UI
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 8),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      equation,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.only(right: 20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      result,
                      style: const TextStyle(color: Colors.white, fontSize: 75),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 35),
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return CustomTextButton(
                      onTap: () {
                        setState(() {
                          equation = '';
                          result = '';
                        });
                      },
                      text: buttons[index],
                      textColor: Colors.black,
                      textSize: 25,
                      backgroundColor: const Color(0xFFA5A5A5),
                    );
                  } else if (index == 1) {
                    return CustomTextButton(
                      onTap: () {
                        setState(() {
                          equation = equation.substring(0, equation.length - 1);
                        });
                      },
                      text: buttons[index],
                      textColor: Colors.black,
                      textSize: 25,
                      backgroundColor: const Color(0xFFA5A5A5),
                    );
                  }
                  //Equal Button (buttons.length - 1 = '=')
                  else if (index == buttons.length - 1) {
                    return CustomTextButton(
                        onTap: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        text: buttons[index],
                        textColor: Colors.white,
                        textSize: 25,
                        backgroundColor: const Color(0xFFFE9E09));
                  } else if (index == 2) {
                    return CustomTextButton(
                      onTap: () {},
                      text: buttons[index],
                      textColor: Colors.black,
                      textSize: 30,
                      backgroundColor: const Color(0xFFA5A5A5),
                    );
                  } else {
                    return CustomTextButton(
                      onTap: () {
                        setState(() {
                          equation += buttons[index];
                        });
                      },
                      text: buttons[index],
                      textColor: Colors.white,
                      textSize: isOperator(buttons[index]) ? 35 : 25,
                      backgroundColor: isOperator(buttons[index])
                          ? const Color(0xFFFE9E09)
                          : const Color(0xFF333333),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

bool isOperator(String x) {
  if (x == '÷' || x == '×' || x == '-' || x == '+' || x == '=') {
    return true;
  }
  return false;
}
