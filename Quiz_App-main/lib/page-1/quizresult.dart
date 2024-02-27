import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';



class quizresult extends StatelessWidget {
  final DatabaseReference databaseReference =
  FirebaseDatabase.instance.reference().child('quiz_results');

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
      body: FirebaseAnimatedList(
        query: databaseReference,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          final data = snapshot.value;
          //print('Data at index $index: $data');

          if (data is Map) {
            // Extract values from the data
            final quizResults = data.values.toList(); // Convert map values to a list

            return Column(
              children: quizResults.map((result) {
                final quizSubject = result['quiz_subject'];
                final userEmail = result['user_email'];
                final userName = result['user_name'];
                final totalQuestions = result['total_questions'];
                final correctAnswers = result['correct_answers'];
                final percentage = result['percentage'];
                final wrongQuestions = totalQuestions - correctAnswers;
                  Text("hello ");
                // Create a card for each user's data
                return Card(
                  child: Column(
                    children: [

                      ListTile(
                        title: Text('Quiz Subject: $quizSubject'),
                        subtitle: Text('User Email: $userEmail'),
                      ),
                      ListTile(
                        title: Text('User Name: $userName'),
                      ),
                      ListTile(
                        title: Text('Total Questions: $totalQuestions'),
                      ),
                      ListTile(
                        title: Text('Correct Answers: $correctAnswers'),
                      ),
                      ListTile(
                        title: Text('Percentage: $percentage%'),
                      ),
                      ListTile(
                        title: Text('Wrong Questions: $wrongQuestions'),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          }

          return ListTile(
            title: Text('Invalid Data at index $index'),
          );
        },
      ),
    );
  }
}
