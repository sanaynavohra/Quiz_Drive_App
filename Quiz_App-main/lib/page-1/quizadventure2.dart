import 'package:flutter/material.dart';
import 'package:quiz_drive/page-1/loginsccreen_3.dart';

class Scenes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading:IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // Set color to black
          onPressed: () {
            Navigator.pop(context);
          },
        ),

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text(
              "Quiz Adventure",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Challenge yourself with a variety of quizzes",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 32),
            Image.asset(
              "assets/page-1/images/layer1.png",
              width: 400,
              height: 400,
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
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
                  child: Text("Get Started"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
