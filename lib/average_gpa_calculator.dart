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
  List<int> grades = [];

  double gpa = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Average & GPA Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Add Subjects and Grades:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: subjectController,
                    decoration: InputDecoration(labelText: 'Subject'),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: gradeController,
                    decoration: InputDecoration(labelText: 'Grade'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      subjects.add(subjectController.text);
                      grades.add(int.parse(gradeController.text));
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (subjects.isNotEmpty)
              for (int i = 0; i < subjects.length; i++)
                Text('${subjects[i]}: ${grades[i]}'),
            SizedBox(height: 20),
            if (subjects.isNotEmpty)
              Text(
                'Average GPA: ${calculateGPA(grades).toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
              onPressed: () {
                setState(() {
                  double scaledGPA = calculateGPA(grades) / 100 * 4;
                  resultText = 'Scaled GPA: $scaledGPA';
                });
              },
              child: Text('Convert to 4.0 Scale'),
            ),
            Text(
              resultText, // Display the result text
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  double calculateGPA(List<int> grades) {
    double totalPoints = 0.0;
    int totalSubjects = grades.length;
    for (int grade in grades){
      totalPoints += grade;
    }
    if (totalSubjects == 0) return 0.0;
    return totalPoints / totalSubjects;
  }
}
