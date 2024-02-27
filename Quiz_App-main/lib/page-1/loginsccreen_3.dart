import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_drive/page-1/accountselection_5.dart';
import 'package:quiz_drive/page-1/CreateAccount_4.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz_drive/page-1/quizadventure2.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _handleGoogleLogin(BuildContext context) async {
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

      print("Account Login Successfully");

      // Account created successfully, navigate to the next screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Selection()),
      );
    } catch (error) {
      print("Error: $error");
    }
  }

  // Function to handle email and password sign-in
  Future<void> _handleEmailSignIn(BuildContext context) async {
    try {
      final String email = _emailController.text;
      final String password = _passwordController.text;

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Sign-in successful, you can navigate to the next screen or take other actions.
      // For now, let's print a success message
      print("Sign-in successful");

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Selection()),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Scenes()),
              );            },
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text(
                "Login with your account",
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
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Enter your email",
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Enter your password",
                      ),
                    ),
                    SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        _handleEmailSignIn(
                            context); // Call the email sign-in function
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
                      child: Text("Sign In"),
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
                          await _handleGoogleLogin(context);
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
                      ),
                    ),
                    SizedBox(height: 30),
                    TextButton(
                      onPressed: () {

                      },
                      child: Text(
                        "Forget Password",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Container(
                      color: Colors.indigo[200],
                      height: 2,
                      width: 50,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()),
                        );
                      },
                      child: Text(
                        "Create New Account",
                        style: TextStyle(color: Colors.black),
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
