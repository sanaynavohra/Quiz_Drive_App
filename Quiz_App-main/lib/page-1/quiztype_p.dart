import 'package:flutter/material.dart';
import 'package:quiz_drive/page-1/mcqs_programming.dart';
import 'package:quiz_drive/page-1/true_programming.dart';
class QuizTypeScreenp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[200],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),

              Text(
                "Quiz Type",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),SizedBox(height: 16),
              Container(
                color: Colors.indigo[200],
                height: 2,
                width: 50,
              ),
              SizedBox(height: 16),
              Text(
                "Select one you'd like to play!",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 32),
              Center(
                child: Column(
                  children: [
                    Container(
                      child:GestureDetector(
                        onTap: ()
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => quiz()),
                          );
                        },
                        child: Image.asset(
                          'assets/page-1/images/multiple-choice-icon-11-1.png',
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  quiz()),
                        );
                      },
                      child: Text(
                        "Multiple Choice Questions",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              Center(
                child: Column(
                  children: [
                    Container(
                      child:GestureDetector(
                        onTap: ()
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  quizt()),
                          );                },
                        child: Image.asset(
                          'assets/page-1/images/practice-checker-1.png',
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  quizt()),
                        );
                      },
                      child: Text(
                        "True / False",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
