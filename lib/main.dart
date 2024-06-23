import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  double firstNum = 0;
  double secondNum = 0;
  String history = '';
  String displayValue = '0';
  String operator = '';
  bool operatorPressed = false;

  void buttonPressed(String buttonText) {
    if (buttonText == 'C') {
      clear();
    } else if (buttonText == '=') {
      calculate();
    } else if (buttonText == '+' ||
        buttonText == '-' ||
        buttonText == '*' ||
        buttonText == '/') {
      if (operatorPressed) {
        calculate();
      }
      operator = buttonText;
      firstNum = double.parse(displayValue);
      displayValue = '0';
      history = firstNum.toString() + operator;
      operatorPressed = true;
    } else {
      if (operatorPressed) {
        displayValue = buttonText;
        operatorPressed = false;
      } else {
        if (displayValue == '0') {
          displayValue = buttonText;
        } else {
          displayValue += buttonText;
        }
      }
    }
    setState(() {});
  }

  void clear() {
    firstNum = 0;
    secondNum = 0;
    operator = '';
    displayValue = '0';
    history = '';
    operatorPressed = false;
  }

  void calculate() {
    secondNum = double.parse(displayValue);
    double result = 0.0;
    switch (operator) {
      case '+':
        result = firstNum + secondNum;
        break;
      case '-':
        result = firstNum - secondNum;
        break;
      case '*':
        result = firstNum * secondNum;
        break;
      case '/':
        if (secondNum != 0) {
          result = firstNum / secondNum;
        } else {
          displayValue = 'Error';
          return;
        }
        break;
    }
    history = firstNum.toString() + operator + secondNum.toString() + '=';
    displayValue = result.toString();
    firstNum = result; // Update firstNum to the latest result
    operatorPressed = false;
  }

  void backspace() {
    if (displayValue.length > 1) {
      displayValue = displayValue.substring(0, displayValue.length - 1);
    } else {
      displayValue = '0';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "CALCULATOR",
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Text(
                history,
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              padding: EdgeInsets.all(10.0),
              alignment: Alignment(1.0, 1.0), // Right-align history
            ),
            Container(
              child: Text(
                displayValue,
                style: TextStyle(fontSize: 40.0, color: Colors.white),
              ),
              padding: EdgeInsets.all(10.0),
              alignment: Alignment(1.0, 1.0), // Right-align display
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => backspace(),
                    child: Text(
                      'x',
                      style: TextStyle(fontSize: 20.0, color: Colors.red),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
                    ),
                  ),
                ],
              ),
              padding: EdgeInsets.all(10.0),
            ),
            Container(
              height: 1.0,
              color: Colors.grey, // Gray line
            ),
            buildButtonRow(['C', '.', '0', '/'], context),
            buildButtonRow(['7', '8', '9', '*'], context),
            buildButtonRow(['4', '5', '6', '-'], context),
            buildButtonRow(['1', '2', '3', '+'], context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => buttonPressed('='),
                  child: Text(
                    '=',
                    style: TextStyle(fontSize: 40.0),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 18, 139, 22),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButtonRow(List<String> buttonTexts, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttonTexts.map((text) {
        return ElevatedButton(
          onPressed: () => buttonPressed(text),
          child: Text(
            text,
            style: TextStyle(fontSize: 40.0),
          ),
          style: ElevatedButton.styleFrom(
            foregroundColor:
                (text == '/' || text == '*' || text == '-' || text == '+')
                    ? Colors.green
                    : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
            padding: EdgeInsets.all(6.0),
            primary: text == '/' ||
                    text == '*' ||
                    text == '-' ||
                    text == '+' ||
                    text == 'C' ||
                    text == '.' ||
                    text == '0'
                ? const Color.fromARGB(255, 46, 46, 46)
                : const Color.fromARGB(255, 71, 71, 71),
          ),
        );
      }).toList(),
    );
  }
}
