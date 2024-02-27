import 'package:flutter/material.dart';
import 'package:quiz_drive/page-1/quiztype_p.dart';
class Selected2 extends StatelessWidget {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),

              Text(
                "Programming Language",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Container(
                color: Colors.indigo[200],
                height: 2,
                width: 50,
              ),
              SizedBox(height: 16),
              Image.asset(
                'assets/page-1/images/programming-coding-1.png',
                width: 300,
                height: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              Text(
                'Programming is the art of instructing a computer to perform specific tasks through a set of instructions, known as code. Its a fundamental skill in the world of technology, enabling the creation of software applications, websites, and various digital solutions. Programmers use programming languages like Python, Java, and JavaScript to write code that controls the behavior of computers.',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 46),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizTypeScreenp()),
                  );
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
                child: Text("Next"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
