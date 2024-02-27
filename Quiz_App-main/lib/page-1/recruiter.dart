import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:quiz_drive/page-1/quizresult.dart';

void main() async {
  runApp(MyApp());
}

class Question {
  String questionText;
  List<String> options;
  int correctOptionIndex; // Index of the correct option in 'options'.

  Question({
    required this.questionText,
    required this.options,
    required this.correctOptionIndex,
  });
}

class Quiz {
  String? id;
  String quizType;
  String quizSubject;
  List<Question> questions;

  Quiz({
    this.id,
    required this.quizType,
    required this.quizSubject,
    required this.questions,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Recruiter(),
    );
  }
}

class Recruiter extends StatefulWidget {
  @override
  _RecruiterState createState() => _RecruiterState();
}

class _RecruiterState extends State<Recruiter> {
  String quizType = 'Multiple Choice Questions'; // Default quiz type
  String quizSubject = 'Data Analysis'; // Default quiz subject
  List<Question> questions = [];

  final DatabaseReference _databaseReference =
  FirebaseDatabase.instance.reference().child('quizzes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
        Size.fromHeight(MediaQuery.of(context).size.height * 0.30),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.indigo[200],
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/page-1/images/rectangle-TTf.png',
                width: 200,
                height: 200,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 40),
              Center(
                child: Text(
                  "Create Your Quiz!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Container(
                  color: Colors.indigo[200],
                  height: 2,
                  width: 50,
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: 300,
                child: DropdownButton<String>(
                  value: quizType,
                  onChanged: (newValue) {
                    setState(() {
                      quizType = newValue!;
                    });
                  },
                  style: TextStyle(color: Colors.black), // Text color
                  icon: Icon(Icons.arrow_drop_down), // Dropdown icon
                  elevation: 16, // Dropdown elevation
                  underline: Container(
                    height: 3, // Customize the underline height
                    color: Colors.indigo[200], // Underline color
                  ),
                  isExpanded: true, // Allow the dropdown to expand horizontally
                  items: ['Multiple Choice Questions', 'True / False'].map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(
                        type,
                        style: TextStyle(
                          fontSize: 16, // Customize the font size
                          color: Colors.black, // Customize the text color
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              Container(
                width: 200, // Set the desired width
                child: DropdownButton<String>(
                  value: quizSubject,
                  onChanged: (newValue) {
                    setState(() {
                      quizSubject = newValue!;
                    });
                  },
                  style: TextStyle(color: Colors.black),
                  icon: Icon(Icons.arrow_drop_down),
                  elevation: 16,
                  underline: Container(
                    height: 3,
                    color: Colors.indigo[200],
                  ),
                  isExpanded: true,
                  items: [
                    'Data Analysis',
                    'Programming Language',
                    'Artificial Intelligence',
                  ].map((subject) {
                    return DropdownMenuItem<String>(
                      value: subject,
                      child: Text(
                        subject,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

            SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  // Add a new question to the list
                  setState(() {
                    if (quizType == 'Multiple Choice Questions') {
                      questions.add(Question(
                        questionText: '',
                        options: ['', '', '', ''],
                        correctOptionIndex: 0,
                      ));
                    } else {
                      questions.add(Question(
                        questionText: '',
                        options: ['True', 'False'],
                        correctOptionIndex: 0,
                      ));
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                primary: Colors.indigo[200],
                onPrimary: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                  side: BorderSide(color: Colors.indigo),
                ),
              ),
                child: Text('Add Question'),
              ),
              for (var i = 0; i < questions.length; i++)
                Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Question ${i + 1}'),
                      onChanged: (value) {
                        setState(() {
                          questions[i].questionText = value;
                        });
                      },
                    ),
                    for (var j = 0; j < questions[i].options.length; j++)
                      TextField(
                        decoration: InputDecoration(labelText: 'Option ${j + 1}'),
                        onChanged: (value) {
                          setState(() {
                            questions[i].options[j] = value;
                          });
                        },
                      ),
                    if (quizType == 'Multiple Choice Questions' || quizType == 'True / False')
                      DropdownButton<int>(
                        value: questions[i].correctOptionIndex,
                        onChanged: (newValue) {
                          setState(() {
                            questions[i].correctOptionIndex = newValue!;
                          });
                        },
                        items: questions[i].options.asMap().entries.map((entry) {
                          int index = entry.key;
                          String option = entry.value;
                          return DropdownMenuItem<int>(
                            value: index,
                            child: Text('Option ${index + 1} - $option'),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              SizedBox(height: 30),

              ElevatedButton(
                  onPressed: () async {
                    // Create a new quiz and add it to the database
                    final quiz = Quiz(
                      quizType: quizType,
                      quizSubject: quizSubject,
                      questions: questions,
                    );

                    try {
                      final newQuizReference = await _databaseReference.push();
                      newQuizReference.set({
                        'quizType': quiz.quizType,
                        'quizSubject': quiz.quizSubject,
                        'questions': quiz.questions.map((question) {
                          return {
                            'questionText': question.questionText,
                            'options': question.options,
                            'correctOptionIndex': question.correctOptionIndex,
                          };
                        }).toList(),
                      });
                      quiz.id = newQuizReference.key;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Quiz added successfully')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error adding quiz')),
                      );
                    }

                    // Clear the input fields
                    setState(() {
                      questions.clear();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo[200], // Button background color
                    onPrimary: Colors.black, // Text color
                    padding: EdgeInsets.symmetric(horizontal: 20), // Adjust padding as needed
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: BorderSide(color: Colors.indigo), // Border color
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12), // Add vertical padding
                    child: Text(
                      'Add Quiz',
                      style: TextStyle(fontSize: 16), // Adjust text size as needed
                    ),
                  ),
                ),




            ],
          ),
        ),
      ),
    );
  }
}

