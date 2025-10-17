import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String input = '';
  String output = '0';
  double num1 = 0;
  double num2 = 0;
  String operator = '';

  Widget calcButton(String btntxt, Color btnColor, Color txtColor) {
    return SizedBox(
      width: 80,
      height: 80,
      child: ElevatedButton(
        onPressed: () => buttonPressed(btntxt),
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor,
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
        ),
        child: Text(btntxt, style: TextStyle(fontSize: 30, color: txtColor)),
      ),
    );
  }

  void buttonPressed(String btnText) {
    setState(() {
      switch (btnText) {
        case 'AC':
          input = '';
          output = '0';
          num1 = 0;
          num2 = 0;
          operator = '';
          break;

        case '⌫': 
          if (input.isNotEmpty) {
            input = input.substring(0, input.length - 1);
            output = input.isEmpty ? '0' : input;
          }
          break;

        case '+':
        case '-':
        case 'x':
        case '/':
          num1 = double.tryParse(output) ?? 0;
          operator = btnText;
          input = '';
          break;

        case '=':
          num2 = double.tryParse(output) ?? 0;
          double result = 0;
          switch (operator) {
            case '+':
              result = num1 + num2;
              break;
            case '-':
              result = num1 - num2;
              break;
            case 'x':
              result = num1 * num2;
              break;
            case '⌫':
              result = num2 != 0 ? num1 / num2 : 0;
              break;
          }
          output = result.toStringAsFixed(
            result.truncateToDouble() == result ? 0 : 2,
          );
          input = '';
          operator = '';
          break;

        default:
          input += btnText;
          output = input;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Calculator"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(16),
                child: Text(
                  output,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 70,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              for (final row in [
                ['⌫','AC', '%','÷'],
                ['7', '8', '9', 'x'],
                ['4', '5', '6', '-'],
                ['1', '2', '3', '+'],
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (final text in row)
                        calcButton(
                          text,
                          _isOperator(text)
                              ? Colors.amber[700]!
                              : (['⌫', 'AC', '%','÷','±'].contains(text)
                                  ? Colors.grey
                                  : Colors.grey[850]!),
                          _isOperator(text)
                              ? Colors.white
                              : (['⌫', 'AC', '%', '÷','±'].contains(text)
                                  ? Colors.black
                                  : Colors.white),
                        ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 170,
                      height: 80,
                      child: ElevatedButton(
                        onPressed: () => buttonPressed('0'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[850],
                          shape: const StadiumBorder(),
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text(
                          "0",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                    ),
                    calcButton(',', Colors.grey[850]!, Colors.white),
                    calcButton('=', Colors.amber[700]!, Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  bool _isOperator(String s) {
    return ['÷', 'x', '-', '+', '='].contains(s);
  }
}
