import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz_drive/page-1/selected_7.dart';
import 'package:quiz_drive/page-1/personal-info.dart';
import 'package:quiz_drive/page-1/loginsccreen_3.dart';
import 'package:quiz_drive/page-1/selected_7_2.dart';
import 'package:quiz_drive/page-1/selected_7_3.dart';


class MainScreen2 extends StatelessWidget {
  Future<User?> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  Future<void> logout(BuildContext context) async {
    final googleSignIn = GoogleSignIn();
    final firebaseAuth = FirebaseAuth.instance;

    bool confirmLogout = false;

    // Show confirmation dialog
    await showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Confirm Logout"),
          content: Text("Are you sure you want to log out?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                confirmLogout = true;

                Navigator.of(dialogContext).pop();
              },
              child: Text(
                "Yes",
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text(
                "No",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );

    if (confirmLogout) {
      // Check if the user is signed in with Google
      if (googleSignIn.currentUser != null) {
        await googleSignIn.disconnect();
        await GoogleSignIn().signOut();
        await FirebaseAuth.instance.signOut();

        FirebaseAuth.instance.signOut();
      }

      // Sign out from Firebase authentication
      if (firebaseAuth.currentUser != null) {
        await firebaseAuth.signOut();
        await GoogleSignIn().signOut();
        FirebaseAuth.instance.signOut();
      }

      // Navigate to the sign-in screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false, // Always return false to remove all routes
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle the back button press here, if needed
        return false; // Returning false blocks the back button
      },
      child:Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[200],
        toolbarHeight: 120,
        // Increased app bar height
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome !",
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            Text(
              "Let's start your Quiz",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          FutureBuilder<User?>(
            future: getCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While waiting for data, display a loading indicator.
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // If there's an error, handle it here.
                return IconButton(
                  icon: Icon(Icons.account_circle, color: Colors.black),
                  onPressed: () {
                    // Handle the error or add your profile icon functionality here.
                  },
                );
              } else {
                // If data is successfully fetched, build the profile icon with the user's photo.
                final User? user = snapshot.data;
                final photoURL = user?.photoURL;

                return IconButton(
                  icon: photoURL != null && photoURL.isNotEmpty
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(photoURL),
                          radius: 15,
                        )
                      : Icon(Icons.account_circle, color: Colors.black),
                  onPressed: () {
                    // Add your profile icon functionality here
                  },
                );
              }
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: IconTheme(
          data: IconThemeData(color: Colors.black), // Set desired icon color
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.indigo[
                      200], // Change the color to your preferred background color
                ),
                accountName: FutureBuilder<User?>(
                  future: FirebaseAuth.instance.authStateChanges().first,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // While waiting for data, return a loading indicator or placeholder.
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // If there's an error, handle it here.
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // If data is successfully fetched, build the account name.
                      final User? user = snapshot.data;
                      final displayName = user?.displayName ?? "Guest User";
                      return Text(displayName);
                    }
                  },
                ),
                accountEmail: FutureBuilder<User?>(
                  future: FirebaseAuth.instance.authStateChanges().first,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // While waiting for data, return a loading indicator or placeholder.
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // If there's an error, handle it here.
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // If data is successfully fetched, build the account email.
                      final User? user = snapshot.data;
                      final email = user?.email ?? "guest@example.com";
                      return Text(email);
                    }
                  },
                ),
                currentAccountPicture: FutureBuilder<User?>(
                  future: FirebaseAuth.instance.authStateChanges().first,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // While waiting for data, display a default profile picture.
                      return CircleAvatar(
                        backgroundColor: Colors.grey,
                      );
                    } else if (snapshot.hasError) {
                      // If there's an error, handle it here.
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // If data is successfully fetched, build the current account picture.
                      final User? user = snapshot.data;
                      final photoURL = user?.photoURL;
                      if (photoURL != null && photoURL.isNotEmpty) {
                        return CircleAvatar(
                          backgroundImage: NetworkImage(photoURL),
                        );
                      } else {
                        return CircleAvatar(
                          backgroundColor: Colors.grey,
                        );
                      }
                    }
                  },
                ),
              ),
              ListTile(
                title: Text("Profile"),
                leading: Icon(
                  Icons.person,
                  color: Colors.black, // Set the initial color
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => personalinfo()),
                  );
                },
              ),
              ListTile(
                title: Text("Logout"),
                leading: Icon(
                  Icons.logout,
                  color: Colors.black, // Set the initial color
                ),
                onTap: () async {
                  await logout(context); // Call the logout function
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Text(
                "Collections",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 300,
                    height: 100,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Selected()),
                        );
                      },
                      child: Image.asset(
                        'assets/page-1/images/f354007466mm4qila3n92ywpseqs82gbwxbb06r1i4-2.png',
                        fit: BoxFit
                            .cover, // Use BoxFit to fill the container with the image
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Selected()),
                );
              },
              child: Text(
                "Data Analysis",
                style: TextStyle(
                  color: Colors.black,
                  // Change the color to your preferred color
                  fontSize: 16,
                  // You can also adjust the font size
                  fontWeight: FontWeight
                      .bold, // You can apply different styles as needed
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 300,
                    height: 100,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Selected2()),
                        );
                      },
                      child: Image.asset(
                        'assets/page-1/images/programming-coding-1.png',
                        fit: BoxFit
                            .cover, // Use BoxFit to fill the container with the image
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Selected2()),
                );              },
              child: Text(
                "Programming Language",
                style: TextStyle(
                  color: Colors.black,
                  // Change the color to your preferred color
                  fontSize: 16,
                  // You can also adjust the font size
                  fontWeight: FontWeight
                      .bold, // You can apply different styles as needed
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 300,
                    height: 100,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Selected3()),
                        );
                      },
                      child: Image.asset(
                        'assets/page-1/images/ai-1.png',
                        fit: BoxFit
                            .cover, // Use BoxFit to fill the container with the image
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Selected3()),
                );              },
              child: Text(
                "Artificial Intelligence",
                style: TextStyle(
                  color: Colors.black,
                  // Change the color to your preferred color
                  fontSize: 16,
                  // You can also adjust the font size
                  fontWeight: FontWeight
                      .bold, // You can apply different styles as needed
                ),
              ),
            ),
          ],
        ),
      ),
    ),);
  }
}
