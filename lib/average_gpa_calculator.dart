import 'package:flutter/material.dart';

class AverageGPACalculator extends StatefulWidget {
  @override
  _AverageGPACalculatorState createState() => _AverageGPACalculatorState();
}

class _AverageGPACalculatorState extends State<AverageGPACalculator> {
  TextEditingController subjectController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  String resultText = "";

  List<String> subjects = [];
  List<double> grades = [];

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
                  icon: const Icon(Icons.add, color: Colors.white),
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  double scaledGPA = calculateGPA(grades) / 100 * 4;
                  resultText = 'Scaled GPA: $scaledGPA';
                });
              },
              style: ElevatedButton.styleFrom (
                backgroundColor: Color.fromARGB(255, 60, 0, 71)
              ),
              child: Text('Convert to 4.0 Scale'),
            ),
            Text(
              resultText, // Display the result text
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
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
}
