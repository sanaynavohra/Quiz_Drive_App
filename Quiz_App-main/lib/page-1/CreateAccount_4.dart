import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz_drive/page-1/loginsccreen_3.dart';
import 'package:quiz_drive/page-1/accountselection_5.dart';


class SignUpScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Function to handle Google Sign-In
  Future<void> _handleGoogleSignIn(BuildContext context) async {
    print("googleLogin method Called");

    GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      var result = await _googleSignIn.signIn();
      if (result == null) {
        print("Login not found");
        return;
      }

      final userData = await result.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: userData.accessToken,
        idToken: userData.idToken,
      );

      await FirebaseAuth.instance.signOut(); // Sign out before signing in

      var finalResult = await FirebaseAuth.instance.signInWithCredential(credential);

      print("Result $result");
      print(result.displayName);
      print(result.email);
      print(result.photoUrl);

      print("Account Created Successfully");

      // Account created successfully, navigate to the next screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Selection()),
      );
    } catch (error) {
      print("Error: $error");
    }
  }


  // Function to handle Email Sign-Up
  Future<void> _handleEmailSignUp(BuildContext context) async {
    try {
      final String username = _usernameController.text;
      final String email = _emailController.text;
      final String password = _passwordController.text;

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store the username in the user's profile or database (you will need to implement this)
      // For demonstration purposes, let's print the username here
      print("Username: $username");
      print("Account Created Successfully");
      // Account created successfully, you can navigate to the next screen or take other actions.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (error) {
      print(error);
    }
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Center(
                child: Text(
                  "Create an Account",
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

                 Text(
                  "Please complete your Profile Details",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.normal,

                  ),
                ),

              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                ),
                controller: _usernameController,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                controller: _emailController,
              ),
              SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                controller: _passwordController,
              ),
              SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _handleEmailSignUp(context);
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
                  child: Text("Continue"),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Container(
                  color: Colors.indigo[200],
                  height: 2,
                  width: 50,
                ),
              ),
              SizedBox(height: 10),
              Center(
                  child: ElevatedButton(
                onPressed: () async {
                  await _handleGoogleSignIn(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo[200],
                  onPrimary: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                    side: BorderSide(color: Colors.indigo),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/page-1/images/google-1.png",
                      width: 26,
                      height: 26,
                    ),
                    SizedBox(width: 8),
                    Text("Google"),
                  ],
                ),
              )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
