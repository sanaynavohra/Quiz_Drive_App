import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quiz_drive/page-1/quizadventure2.dart';
import 'package:quiz_drive/firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform
    );
    print("Firebase Initialization Successfully. ");

  } catch (error) {
    print("Firebase Initialization Error: $error");
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recruitment Drive',
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/page-1/images/background.png',
            fit: BoxFit.cover,
          ),
          // Centered Clickable Image
          Center(

            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Scenes()),
                );
              },
              child: Image.asset(
                'assets/page-1/images/layer2-5km.png',
                width: 300,
                height: 300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second Screen')),
      body: Center(
        child: Text('Welcome to the Second Screen!'),
      ),
    );
  }
}
