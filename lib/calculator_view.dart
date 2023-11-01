import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'calc_button.dart';
import 'average_gpa_calculator.dart'; // Import the AverageGPACalculator

class CalculatorView extends StatefulWidget {
  const CalculatorView({Key? key}) : super(key: key);

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    // used to check if the result contains a decimal
    String doesContainDecimal(dynamic result) {
      if (result.toString().contains('.')) {
        List<String> splitDecimal = result.toString().split('.');
        if (!(int.parse(splitDecimal[1]) > 0)) {
          return result = splitDecimal[0].toString();
        }
      }
      return result;
    }

    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "0";
      } else if (buttonText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "+/-") {
        if (equation[0] != '-') {
          equation = '-$equation';
        } else {
          equation = equation.substring(1);
        }
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('%', '%');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          if (expression.contains('%')) {
            result = doesContainDecimal(result);
          }
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        title: Text('Calculator View'), // Set the app bar title
        backgroundColor: Color.fromARGB(255, 60, 0, 71),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // "Go to Average & GPA Calculator" button positioned in the top-left corner
            Align(
              alignment: Alignment.topLeft,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the Average & GPA Calculator screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AverageGPACalculator()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 60, 0, 71),
                  shape: StadiumBorder(),  
                ),
                child: Text('Go to Average & GPA Calculator'),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(result,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 80))),
                        const Icon(Icons.more_vert,
                            color: Color.fromARGB(255, 18, 0, 71), size: 30),
                        const SizedBox(width: 20),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(equation,
                              style: const TextStyle(
                                fontSize: 40,
                                color: Colors.white38,
                              )),
                        ),
                        IconButton(
                          icon: const Icon(Icons.backspace_outlined,
                              color: Color.fromARGB(255, 103, 0, 121), size: 30),
                          onPressed: () {
                            buttonPressed("⌫");
                          },
                        ),
                        const SizedBox(width: 20),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('AC', Colors.white10, () => buttonPressed('AC')),
                calcButton('%', Colors.white10, () => buttonPressed('%')),
                calcButton('÷', Colors.white10, () => buttonPressed('÷')),
                calcButton("×", Colors.white10, () => buttonPressed('×')),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('7', Colors.white24, () => buttonPressed('7')),
                calcButton('8', Colors.white24, () => buttonPressed('8')),
                calcButton('9', Colors.white24, () => buttonPressed('9')),
                calcButton('-', Colors.white10, () => buttonPressed('-')),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('4', Colors.white24, () => buttonPressed('4')),
                calcButton('5', Colors.white24, () => buttonPressed('5')),
                calcButton('6', Colors.white24, () => buttonPressed('6')),
                calcButton('+', Colors.white10, () => buttonPressed('+')),
              ],
            ),
            const SizedBox(height: 10),
            // calculator number buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        calcButton(
                            '1', Colors.white24, () => buttonPressed('1')),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04),
                        calcButton(
                            '2', Colors.white24, () => buttonPressed('2')),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04),
                        calcButton(
                            '3', Colors.white24, () => buttonPressed('3')),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        calcButton('+/-', Colors.white24,
                            () => buttonPressed('+/-')),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04),
                        calcButton(
                            '0', Colors.white24, () => buttonPressed('0')),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.04),
                        calcButton(
                            '.', Colors.white24, () => buttonPressed('.')),
                      ],
                    ),
                  ],
                ),
                calcButton('=', Color.fromARGB(255, 60, 0, 71), () => buttonPressed('=')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
