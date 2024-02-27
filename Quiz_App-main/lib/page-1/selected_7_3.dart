import 'package:flutter/material.dart';
import 'package:quiz_drive/page-1/quiztype_AI.dart';
class Selected3 extends StatelessWidget {
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
                "Artificial Intelligence",
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
                'assets/page-1/images/ai-1.png',
                width: 300,
                height: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              Text(
                'Artificial Intelligence, or AI, is a branch of computer science dedicated to creating intelligent machines that can mimic human-like thinking and decision-making processes. AI systems are designed to learn from data, recognize patterns, and make predictions or decisions without explicit programming. Machine learning and deep learning are subfields of AI that have revolutionized various industries, from healthcare to finance. ',
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
                    MaterialPageRoute(builder: (context) => QuizTypeScreenai()),
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
