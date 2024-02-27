import 'package:flutter/material.dart';
import 'package:quiz_drive/page-1/welcome_6.dart';

import 'package:quiz_drive/page-1/welcom_r.dart';
class Selection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      // Handle the back button press here, if needed
      return false; // Returning false blocks the back button
    },
    child: Scaffold(
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
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),

              Text(
                "What type of Account Will You Use?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
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
              SizedBox(height: 80),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainScreen()),
                    );
                  },
                  icon: Icon(Icons.business),
                  label: Text("Recruiter"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo[200],
                    onPrimary: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 80,vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: BorderSide(color: Colors.indigo),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 36),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainScreen2()),
                    );
                    },
                  icon: Icon(Icons.person),
                  label: Text("Candidate"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo[200],
                    onPrimary: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 80,vertical: 20),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: BorderSide(color: Colors.indigo),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    ),
    );
  }
}
