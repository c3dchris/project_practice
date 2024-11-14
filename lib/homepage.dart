import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:math_expressions/math_expressions.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List actionButtons = [0, 1, 2];
  List numberButtons = [4, 5, 6, 8, 9, 10, 12, 13, 14, 16, 17, 18];
  List opeatorButtons = [3, 7, 11, 15, 19];

  List buttonValues = [
    'C',
    '+/-',
    '%',
    "/",
    "7",
    "8",
    "9",
    "x",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    ".",
    "0",
    "<",
    "=",
  ];

  String primaryDisplayValue = "";
  String secondaryDisplayValue = "";

  void addToCalculator(String x) {
    setState(() {
      primaryDisplayValue += x;
    });
  }

  void clearText() {
    setState(() {
      primaryDisplayValue = "";
      secondaryDisplayValue = "";
    });
  }

  void removeLastCharacter() {
    setState(() {
      primaryDisplayValue =
          primaryDisplayValue.substring(0, primaryDisplayValue.length - 1);
    });
  }

  void calculateResult() {
    setState(() {
      Parser p = Parser();
      Expression exp = p.parse(primaryDisplayValue);
      String result =
          exp.evaluate(EvaluationType.REAL, ContextModel()).toString();
      secondaryDisplayValue = primaryDisplayValue;
      primaryDisplayValue = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F2F3),
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 32,
                    width: 72,
                    decoration: BoxDecoration(
                      color: Color(0xfff),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 4, top: 4, bottom: 4),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/sun.svg',
                            semanticsLabel: 'My SVG Image',
                            height: 24,
                            width: 24,
                          ),
                          SizedBox(width: 12),
                          Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              color: Color(0xffD2D3DA),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //todo container text
            Container(
              margin: EdgeInsets.only(top: 55, left: 20, right: 20, bottom: 32),
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      secondaryDisplayValue.toString(),
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w300,
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      primaryDisplayValue.toString(),
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 96,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: buttonValues.length,
                        itemBuilder: (BuildContext context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: GestureDetector(
                              onTap: () {
                                index == 0
                                    ? clearText()
                                    : index == 18
                                        ? removeLastCharacter()
                                        : index == 19 ? calculateResult():  addToCalculator(buttonValues[index]);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: actionButtons.contains(index)
                                      ? Color(0xffD2D3DA)
                                      : numberButtons.contains(index)
                                          ? Color(0xfffff)
                                          : Color(0xff4B5EFC),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Center(
                                  child: Text(
                                    buttonValues[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 28,
                                      color: opeatorButtons.contains(index)
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
