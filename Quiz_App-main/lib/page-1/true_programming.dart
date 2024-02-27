import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:quiz_drive/page-1/welcome_6.dart';
import 'dart:async';



class Quiz {
  final String quizSubject;
  final String quizType;
  final List<Question> questions;

  Quiz({
    required this.quizSubject,
    required this.quizType,
    required this.questions,
  });

  factory Quiz.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map<dynamic, dynamic>;
    final List<dynamic> questionsData = data['questions'];
    final List<Question> questions = questionsData
        .map((questionData) => Question.fromMap(questionData))
        .toList();

    return Quiz(
      quizSubject: data['quizSubject'],
      quizType: data['quizType'],
      questions: questions,
    );
  }
}

class Question {
  final List<String> options;
  final int correctOptionIndex;
  final String questionText;

  Question({
    required this.options,
    required this.correctOptionIndex,
    required this.questionText,
  });

  factory Question.fromMap(Map<dynamic, dynamic> map) {
    return Question(
      options: List<String>.from(map['options']),
      correctOptionIndex: map['correctOptionIndex'],
      questionText: map['questionText'],
    );
  }
}



class quizt extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<quizt> {
  final DatabaseReference databaseReference =
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
            icon: Icon(Icons.arrow_back,color: Colors.black),
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
      body:


      FirebaseAnimatedList(
        query: databaseReference,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          final quiz = Quiz.fromSnapshot(snapshot);

          // Check if the quiz subject is "AI" and quiz type is "Multiple Choice Question"
          if (quiz.quizSubject == "Programming Language" &&
              quiz.quizType == "True / False") {
            return Card(
              margin: EdgeInsets.all(16),
              child: ListTile(
                title: Text(quiz.quizSubject),
                subtitle: Text("Quiz Type: ${quiz.quizType}"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizDetailsScreen(quiz: quiz),
                    ),
                  );
                },
              ),
            );
          } else {
            // If the subject or type doesn't match, return an empty container
            return Container();
          }
        },
      ),
    );
  }
}

class QuizDetailsScreen extends StatefulWidget {
  final Quiz quiz;

  QuizDetailsScreen({required this.quiz});

  @override
  _QuizDetailsScreenState createState() => _QuizDetailsScreenState();
}

class _QuizDetailsScreenState extends State<QuizDetailsScreen> {
  late List<int?> selectedOptions;
  int totalQuestions = 0;
  int correctAnswers = 0;
  double percentage = 0.0;


  @override
  void initState() {
    super.initState();
    selectedOptions = List.generate(widget.quiz.questions.length, (_) => null);


  }

  Future<void> submitQuiz(BuildContext context) async {
    // Calculate the total number of questions
    totalQuestions = widget.quiz.questions.length;

    // Calculate the number of correct answers
    correctAnswers = 0;

    for (int i = 0; i < totalQuestions; i++) {
      final question = widget.quiz.questions[i];
      final correctOptionIndex = question.correctOptionIndex;
      final selectedOptionIndex = selectedOptions[i];

      if (selectedOptionIndex == correctOptionIndex) {
        correctAnswers++;
      }
    }

    // Calculate the percentage
    percentage = (correctAnswers / totalQuestions) * 100;

    // Save quiz results to Firebase Realtime Database
    await saveQuizResults();

    // Navigate to the results screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => QuizResultsScreen(
          totalQuestions: totalQuestions,
          correctAnswers: correctAnswers,
          percentage: percentage,
        ),
      ),
    );
  }

  Future<void> saveQuizResults() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      final DatabaseReference databaseReference = FirebaseDatabase.instance
          .reference()
          .child('quiz_results')
          .child(user.uid)
          .push(); // Use user's UID as a key

      final Map<String, dynamic> resultData = {
        'user_name': user.displayName, // User's display name (set during authentication)
        'user_email': user.email, // User's email address
        'quiz_subject': widget.quiz.quizSubject,
        'total_questions': totalQuestions,
        'correct_answers': correctAnswers,
        'percentage': percentage,
      };

      await databaseReference.set(resultData);

      print("Quiz results saved successfully.");
    } else {
      print("User is not authenticated.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:

      PreferredSize(
        preferredSize:
        Size.fromHeight(MediaQuery.of(context).size.height * 0.30),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.indigo[200],
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.black),
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
      body:

      Column(
        children: <Widget>[
          SizedBox(height: 16), // Add a SizedBox before the Text
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.quiz.quizSubject,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10), // Add a SizedBox after the Text


          Center(
            child: Container(
              color: Colors.indigo[200],
              height: 2,
              width: 50,
            ),
          ),
          SizedBox(height: 16),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: widget.quiz.questions.length,
              itemBuilder: (context, index) {
                final question = widget.quiz.questions[index];

                return Card(
                  margin: EdgeInsets.all(16),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Question ${index + 1}",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(question.questionText),
                        SizedBox(height: 16),
                        Text("Options:"),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            question.options.length,
                                (optionIndex) {
                              return RadioListTile<int?>(
                                value: optionIndex,
                                groupValue: selectedOptions[index],
                                onChanged: (value) {
                                  setState(() {
                                    selectedOptions[index] = value;
                                  });
                                },
                                title: Text(
                                  question.options[optionIndex],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            submitQuiz(context);
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
          child: Text('Submit Quiz'),
        ),

      ),
    );
  }
}

class QuizResultsScreen extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;
  final double percentage;

  QuizResultsScreen({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle the back button press here, if needed
        return false; // Returning false blocks the back button
      },
      child: Scaffold(
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
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 40),
              Text(
                "Quiz Score",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Container(
                color: Colors.indigo[200],
                height: 2,
                width: 50,
              ),
              SizedBox(height: 46),
              Text('Total Questions: $totalQuestions'),
              Text('Correct Answers: $correctAnswers'),
              Text('Percentage: ${percentage.toStringAsFixed(2)}%'),
              SizedBox(height: 46),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen2()),
                  ); // Call the email sign-in function
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
                child: Text("Back To Home "),
              ),
            ],

          ),

        ),

      ),);
  }
}


