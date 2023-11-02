// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AverageGPACalculator extends StatefulWidget {
  @override
  _AverageGPACalculatorState createState() => _AverageGPACalculatorState();
}

class _AverageGPACalculatorState extends State<AverageGPACalculator> {
  TextEditingController subjectController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  TextEditingController targetController = TextEditingController();
  String resultText = "";

  List<String> subjects = [];
  List<double> grades = [];
  double target = 0.0;
  double points = 0.0;
  double gpa = 0.0;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        title: Text('Average & GPA Calculator'),
        backgroundColor: Color.fromARGB(255, 60, 0, 71),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Add Subjects and Grades:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    controller: subjectController,
                    decoration: InputDecoration(
                      labelText: 'Subject',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                      )
                      ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    controller: gradeController,
                    decoration: InputDecoration(
                      labelText: 'Grade',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                      )
                      ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline, color: Color.fromARGB(255, 116, 8, 136)),
                  onPressed: () {
                    setState(() {
                      if (double.parse(gradeController.text) >= 0){
                        subjects.add(subjectController.text);
                        grades.add(double.parse(gradeController.text));
                        subjectController.clear();
                        gradeController.clear();
                      }
                      subjectController.clear();
                      gradeController.clear();
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Subjects and Grades:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
            ),
            if (subjects.isNotEmpty)
              for (int i = 0; i < subjects.length; i++)
                Text('${subjects[i]}: ${grades[i]}', style: TextStyle(color: Colors.white),),
            SizedBox(height: 20),
            if (subjects.isNotEmpty)
              Text(
                'Average GPA: ${calculateGPA(grades).toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 215, 0, 253)),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  double scaledGPA = 0;
                  if (calculateGPA(grades) >= 93){
                    scaledGPA = 4.0;
                  }
                  else if (calculateGPA(grades) >= 90){
                    scaledGPA = 3.7;
                  }
                  else if (calculateGPA(grades) >= 87){
                    scaledGPA = 3.3;
                  }
                  else if (calculateGPA(grades) >= 83){
                    scaledGPA = 3.0;
                  }
                  else if (calculateGPA(grades) >= 80){
                    scaledGPA = 2.7;
                  }
                  else if (calculateGPA(grades) >= 77){
                    scaledGPA = 2.3;
                  }
                  else if (calculateGPA(grades) >= 73){
                    scaledGPA = 2.0;
                  }
                  else if (calculateGPA(grades) >= 70){
                    scaledGPA = 1.7;
                  }
                  else if (calculateGPA(grades) >= 67){
                    scaledGPA = 1.3;
                  }
                  else if (calculateGPA(grades) >= 65){
                    scaledGPA = 1.0;
                  }
                  else {
                    scaledGPA = 0.0;
                  }
                  resultText = 'Scaled GPA: $scaledGPA';
                });
              },
              style: ElevatedButton.styleFrom (
                backgroundColor: Color.fromARGB(255, 60, 0, 71)
              ),
              child: Text('Convert to 4.0 Scale'),
            ),
            SizedBox(height: 20),
            Text(
              resultText, // Display the result text
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
            ),
            SizedBox(height: 35),
            if(subjects.isNotEmpty)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:<Widget>[
                    Text(
                      'Enter Targeted Average:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                    child: TextField(
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    controller: targetController,
                    decoration: InputDecoration(
                      labelText: 'Target Average',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                      )
                      )
                    )
                    ),
                    IconButton(
                    icon: const Icon(Icons.add_circle_outline, color: Color.fromARGB(255, 116, 8, 136)),
                    onPressed: () {
                      setState(() {
                        target = (double.parse(targetController.text));
                        targetController.clear();
                      });
                    },
                  ),
                  ]
                ),
                SizedBox(height: 20),
                if(target != 0.0)
                  Text(
                  'You will need to increase your total grade by ${points_required(target)} points to reach $target',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
                  ),
          ],
        ),
      ),
    );
  }

  double calculateGPA(List<double> grades) {
    double totalPoints = 0.0;
    int totalSubjects = grades.length;
    for (double grade in grades){
      totalPoints += grade;
    }
    if (totalSubjects == 0) return 0.0;
    return totalPoints / totalSubjects;
  }

  double points_required(double num){
    return (num * subjects.length) - (calculateGPA(grades) * subjects.length);
  }
}
//Enter desired Average:
//Returns: {num} more points required to reach {desired_average}
//formula: Desired * subjects.length - avg * subjects.length