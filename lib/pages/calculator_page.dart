// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_calculator/pages/profile_page.dart';
// import 'package:my_calculator/widgets/drawer.dart';
// import '../widgets/bottom_navigation.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/calculator_button.dart';

class CalculatorPage extends StatefulWidget {
  static const String routeName = 'calculator';
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  late int firstNum;
  late int secondNum;
  late String history = '';
  late String textToDisplay = '';
  late String res = '';
  late String operation = '';

  void btnOnClick(btnVal) {
    //print(btnVal);
    if (btnVal == 'C') {
      textToDisplay = '';
      firstNum = 0;
      secondNum = 0;
      res = '';
    } else if (btnVal == 'AC') {
      textToDisplay = '';
      firstNum = 0;
      secondNum = 0;
      res = '';
      history = '';
    } else if (btnVal == '+' ||
        btnVal == '-' ||
        btnVal == 'X' ||
        btnVal == '/') {
      firstNum = int.parse(textToDisplay);
      res = '';
      operation = btnVal;
    } else if (btnVal == '+/-') {
      if (textToDisplay[0] != '-') {
        res = '-$textToDisplay';
      } else {
        res = textToDisplay.substring(1);
      }
    } else if (btnVal == '<') {
      res = textToDisplay.substring(0, textToDisplay.length - 1);
    } else if (btnVal == '=') {
      secondNum = int.parse(textToDisplay);
      if (operation == '+') {
        res = (firstNum + secondNum).toString();
        history =
            firstNum.toString() + operation.toString() + secondNum.toString();
      }
      if (operation == '-') {
        res = (firstNum - secondNum).toString();
        history =
            firstNum.toString() + operation.toString() + secondNum.toString();
      }
      if (operation == 'X') {
        res = (firstNum * secondNum).toString();
        history =
            firstNum.toString() + operation.toString() + secondNum.toString();
      }
      if (operation == '/') {
        res = (firstNum / secondNum).toString();
        history =
            firstNum.toString() + operation.toString() + secondNum.toString();
      }
    } else {
      res = int.parse(textToDisplay + btnVal).toString();
    }

    setState(() {
      textToDisplay = res;
    });
  }

  List SideTopMenu = <String>[
    "Settings",
    "Quit App",
  ];

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: Text("Simple Calculator".toUpperCase()),
      ),
      backgroundColor: Color(0xFF28527a),
      bottomNavigationBar: BottomNav(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                // ignore: sort_child_properties_last
                child: Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Text(
                    history,
                    style: GoogleFonts.rubik(
                        textStyle:
                            TextStyle(fontSize: 25, color: Color(0x66FFFFFF))),
                  ),
                ),
                alignment: Alignment(1.0, 1.0),
              ),
              Container(
                alignment: Alignment(1.0, 1.0),
                child: Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Text(
                    textToDisplay,
                    style: GoogleFonts.rubik(
                        textStyle:
                            TextStyle(fontSize: 50, color: Colors.white)),
                  ),
                ),
              ),
              Divider(
                height: 10,
                color: Color(0x66FFFFFF),
                thickness: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  CalculatorButton(
                      text: 'AC',
                      fillColor: 0xFF8ac4d0,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: btnOnClick),
                  CalculatorButton(
                      text: 'C',
                      fillColor: 0xFF8ac4d0,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: btnOnClick),
                  CalculatorButton(
                      text: '<',
                      fillColor: 0xFFf4d160,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: btnOnClick),
                  CalculatorButton(
                      text: '/',
                      fillColor: 0xFFf4d160,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: btnOnClick),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  CalculatorButton(
                      text: '9',
                      fillColor: 0xFF8ac4d0,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: btnOnClick),
                  CalculatorButton(
                      text: '8',
                      fillColor: 0xFF8ac4d0,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: btnOnClick),
                  CalculatorButton(
                      text: '7',
                      fillColor: 0xFF8ac4d0,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: btnOnClick),
                  CalculatorButton(
                      text: 'X',
                      fillColor: 0xFFf4d160,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: btnOnClick),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  CalculatorButton(
                      text: '6',
                      fillColor: 0xFF8ac4d0,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: btnOnClick),
                  CalculatorButton(
                      text: '5',
                      fillColor: 0xFF8ac4d0,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: btnOnClick),
                  CalculatorButton(
                      text: '4',
                      fillColor: 0xFF8ac4d0,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: btnOnClick),
                  CalculatorButton(
                      text: '-',
                      fillColor: 0xFFf4d160,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: btnOnClick),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  CalculatorButton(
                      text: '3',
                      fillColor: 0xFF8ac4d0,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: btnOnClick),
                  CalculatorButton(
                      text: '2',
                      fillColor: 0xFF8ac4d0,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: btnOnClick),
                  CalculatorButton(
                      text: '1',
                      fillColor: 0xFF8ac4d0,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: btnOnClick),
                  CalculatorButton(
                      text: '+',
                      fillColor: 0xFFf4d160,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: btnOnClick),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  CalculatorButton(
                      text: '+/-',
                      fillColor: 0xFF8ac4d0,
                      textColor: 0xFF000000,
                      textSize: 16,
                      callback: btnOnClick),
                  CalculatorButton(
                      text: '0',
                      fillColor: 0xFF8ac4d0,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: btnOnClick),
                  CalculatorButton(
                      text: '00',
                      fillColor: 0xFF8ac4d0,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: btnOnClick),
                  CalculatorButton(
                      text: '=',
                      fillColor: 0xFFf4d160,
                      textColor: 0xFF000000,
                      textSize: 20,
                      callback: btnOnClick),
                ],
              )
            ],
          ),
        ),
      ),
      //drawer: MyDrawer(),
    ));
  }
}
