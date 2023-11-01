import 'package:flutter/material.dart';
import 'calculator_view.dart';
import 'average_gpa_calculator.dart';
// ignore: duplicate_import
import 'package:calculator_app/calculator_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => CalculatorView(),
        '/average_gpa_calculator': (context) => AverageGPACalculator(),
      },
    );
  }
}
