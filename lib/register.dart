import 'package:flutter/material.dart';
import 'login.dart'; // Import the LoginPage widget
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart'; // Import for LengthLimitingTextInputFormatter

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _customerNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  String _errorMessage = '';
  bool _showPassword = false;

  void _submitData() async {
    final String databaseUrl = 'https://chatapp-c20c6-default-rtdb.asia-southeast1.firebasedatabase.app';
    final String userDataUrl = '$databaseUrl/userData';

    try {
      // Get user input
      final username = _mobileNumberController.text;
      final name = _customerNameController.text;
      final password = _passwordController.text;
      final confirmPassword = _confirmPasswordController.text;

      // Validate fields
      if (username.isEmpty ||
          name.isEmpty ||
          password.isEmpty ||
          confirmPassword.isEmpty) {
        setState(() {
          _errorMessage = 'All fields are required.';
        });
        return;
      }

      // Validate mobile number
      if (username.length != 10 || int.tryParse(username) == null) {
        setState(() {
          _errorMessage = 'Mobile number must be a 10-digit numeric value.';
        });
        return;
      }

      // Validate password match
      if (password != confirmPassword) {
        setState(() {
          _errorMessage = 'Passwords do not match.';
        });
        return;
      }

      // Create user data map
      Map<String, dynamic> userData = {
        'username': username,
        'name': name,
        'password': password,
      };

      // Construct URL with user's input name
      final String userUrl = '$userDataUrl/$username.json';

      // Send PUT request to create or update user node directly under userData
      final response = await http.put(
        Uri.parse(userUrl),
        body: json.encode(userData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('User data submitted successfully');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()), // Navigate to LoginPage
        );
      } else {
        print('Failed to submit user data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error submitting user data: $e');
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
                  'Register',
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
                  color: Color.fromRGBO(255, 255, 255, 0.5), // 50% transparent white
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _mobileNumberController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [LengthLimitingTextInputFormatter(10)], // Restrict input to 10 characters
                      decoration: InputDecoration(
                        labelText: 'Mobile Number',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0), // Set the border radius here
                          borderSide: BorderSide.none, // Remove the border color
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: _customerNameController,
                      decoration: InputDecoration(
                        labelText: 'Customer Name',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0), // Set the border radius here
                          borderSide: BorderSide.none, // Remove the border color
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: _passwordController,
                      obscureText: !_showPassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0), // Set the border radius here
                          borderSide: BorderSide.none, // Remove the border color
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: !_showPassword,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0), // Set the border radius here
                          borderSide: BorderSide.none, // Remove the border color
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      _errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(
                      height: 50.0, // Set the desired height of the button
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _errorMessage = ''; // Clear error message before validation
                          });
                          _submitData();
                        },
                        child: Text(
                          'Register',
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
                          fixedSize: MaterialStateProperty.all<Size>(
                            Size(double.infinity, 50.0),
                          ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0), // Set the border radius here
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
                    MaterialPageRoute(builder: (context) => LoginPage()), // Navigate to LoginPage
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: 'Login.',
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
