import 'package:flutter/material.dart';
import 'package:quiz_drive/page-1/quiztype_8.dart';
class Selected extends StatelessWidget {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text(
              "Data Analysis",
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
              'assets/page-1/images/f354007466mm4qila3n92ywpseqs82gbwxbb06r1i4-1.png',
              width: 300,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              'What do you know about data analytics? Could you pass this quiz? Data analytics is the framework for the organization’s data. Their main objective is to extract information from a disparate source and examine, clean, and model the data to determine useful information that the business may need. It helps organizations to regulate their data and utilize it to identify new opportunities. Take this quiz and put your expertise in data analytics to the test.',
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
                  MaterialPageRoute(builder: (context) => QuizTypeScreen()),
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
    );
  }
}
