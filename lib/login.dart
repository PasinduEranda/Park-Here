import 'package:flutter/material.dart';
import 'register.dart';
import 'menu.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Import the MenuPage widget

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void showErrorMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.error), // Default error icon
              SizedBox(width: 8),
              Text('Error'),
            ],
          ),
          content: Text('The username or password is incorrect.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void checkUser() async {
    final String databaseUrl =
        'https://chatapp-c20c6-default-rtdb.asia-southeast1.firebasedatabase.app';
    final String userDataUrl = '$databaseUrl/userData';

    try {
      // Get user input
      final username = _usernameController.text;
      final password = _passwordController.text;

      // Send GET request to retrieve user data
      final Uri uri = Uri.parse(
          '$userDataUrl.json?orderBy="username"&equalTo="$username"');
      final http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = json.decode(response.body);

        // Check if user exists and password matches
        if (userData.isNotEmpty) {
          final String userId = userData.keys.first; // Get the user ID
          final Map<String, dynamic> userInfo =
              userData[userId]; // Get the user info
          final String receivedUsername =
              userInfo['username']; // Get received username
          final String receivedPassword =
              userInfo['password']; // Get received password

          // Print received username and password from Firebase
          print('Received username from Firebase: $receivedUsername');
          print('Received password from Firebase: $receivedPassword');

          if (password == receivedPassword) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MenuPage()),
            );
          } else {
            showErrorMessage(context);
          }
        } else {
          showErrorMessage(context);
        }
      } else {
        print(
            'Failed to retrieve user data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error checking user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF545151), // Set background color to transparent
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF545151), // 25% transparent black
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 30.0),
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Color(0xFF6B9797),
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color:
                      Color.fromRGBO(255, 255, 255, 0.5), // 50% transparent white
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Mobile Number',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextButton(
                      onPressed: () {
                        // Add code for "Forgot Password" functionality
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    SizedBox(
                      height: 50.0, // Set the desired height of the button
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          checkUser();
                          // Check if the entered mobile number and password are valid
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white, // Set button text color to white
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFFFFBF00), // Set button color to FFBF00
                          ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0), // Add space between the login details and the sign up text
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Don’t have an account ? ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: 'Register.',
                        style: TextStyle(
                          color: Color(0xFFFFBF00),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
