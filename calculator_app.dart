import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String displayText = "0";
  String firstOperand = "";
  String secondOperand = "";
  String operator = "";
  bool isSecondOperand = false;

  void onNumberPress(String number) {
    setState(() {
      if (isSecondOperand) {
        secondOperand += number;
        displayText = secondOperand;
      } else {
        firstOperand += number;
        displayText = firstOperand;
      }
    });
  }

  void onOperatorPress(String op) {
    setState(() {
      if (firstOperand.isNotEmpty) {
        operator = op;
        isSecondOperand = true;
      }
    });
  }

  void onEqualPress() {
    if (firstOperand.isNotEmpty &&
        secondOperand.isNotEmpty &&
        operator.isNotEmpty) {
      double num1 = double.parse(firstOperand);
      double num2 = double.parse(secondOperand);
      double result = 0;

      switch (operator) {
        case "+":
          result = num1 + num2;
          break;
        case "-":
          result = num1 - num2;
          break;
        case "*":
          result = num1 * num2;
          break;
        case "/":
          if (num2 != 0) {
            result = num1 / num2;
          } else {
            displayText = "Error";
            return;
          }
          break;
        case "%":
          result = num1 % num2;
          break;
      }

      setState(() {
        displayText = result.toString();
        firstOperand = displayText;
        secondOperand = "";
        operator = "";
        isSecondOperand = false;
      });
    }
  }

  void onClearPress() {
    setState(() {
      displayText = "0";
      firstOperand = "";
      secondOperand = "";
      operator = "";
      isSecondOperand = false;
    });
  }

  Widget buildButton(String text, Color color, Function() onPressed) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20),
            backgroundColor: color,
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              color: Colors.black,
              child: Text(
                displayText,
                style: TextStyle(fontSize: 48, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Row(
                  children: [
                    buildButton("7", Colors.grey, () => onNumberPress("7")),
                    buildButton("8", Colors.grey, () => onNumberPress("8")),
                    buildButton("9", Colors.grey, () => onNumberPress("9")),
                    buildButton("/", Colors.orange, () => onOperatorPress("/")),
                  ],
                ),
                Row(
                  children: [
                    buildButton("4", Colors.grey, () => onNumberPress("4")),
                    buildButton("5", Colors.grey, () => onNumberPress("5")),
                    buildButton("6", Colors.grey, () => onNumberPress("6")),
                    buildButton("*", Colors.orange, () => onOperatorPress("*")),
                  ],
                ),
                Row(
                  children: [
                    buildButton("1", Colors.grey, () => onNumberPress("1")),
                    buildButton("2", Colors.grey, () => onNumberPress("2")),
                    buildButton("3", Colors.grey, () => onNumberPress("3")),
                    buildButton("-", Colors.orange, () => onOperatorPress("-")),
                  ],
                ),
                Row(
                  children: [
                    buildButton("C", Colors.red, onClearPress),
                    buildButton("0", Colors.grey, () => onNumberPress("0")),
                    buildButton("=", Colors.green, onEqualPress),
                    buildButton("+", Colors.orange, () => onOperatorPress("+")),
                  ],
                ),
                Row(
                  children: [
                    buildButton("%", Colors.orange, () => onOperatorPress("%")),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
