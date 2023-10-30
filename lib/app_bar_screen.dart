import 'package:flutter/material.dart';
import 'calculator_view.dart';

class AppBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Bar Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CalculatorView()));
              },
              child: Text('Go to Calculator'),
            ),
            ElevatedButton(
              onPressed: () {
              },
              child: Text('Go to Average GPA Calculator'),
            ),
          ],
        ),
      ),
    );
  }
}
