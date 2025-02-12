import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login.dart';
//import 'success.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final String apiUrl =
      'http://192.168.1.115:8000/api/main/register/'; // Replace this with your actual API URL

  String usernameError = '';
  String phoneError = '';
  String passwordError = '';
  String confirmPasswordError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.green],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Create an Account',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                _buildInputField(
                  usernameController,
                  'Username',
                  Icons.person,
                  usernameError,
                ),
                SizedBox(height: 10.0),
                _buildInputField(
                  phoneController,
                  'Phone Number',
                  Icons.phone,
                  phoneError,
                ),
                SizedBox(height: 10.0),
                _buildPasswordField(
                  passwordController,
                  'Password',
                  Icons.lock,
                  passwordError,
                ),
                SizedBox(height: 10.0),
                _buildPasswordField(
                  confirmPasswordController,
                  'Confirm Password',
                  Icons.lock,
                  confirmPasswordError,
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      usernameError = '';
                      phoneError = '';
                      passwordError = '';
                      confirmPasswordError = '';
                    });

                    var response = await http.post(
                      Uri.parse(apiUrl),
                      body: {
                        'username': usernameController.text,
                        'phone_number': phoneController.text,
                        'password': passwordController.text,
                        'confirm_password': confirmPasswordController.text,
                      },
                    );

                    if (response.statusCode == 201) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    } else {
                      var responseData = json.decode(response.body);
                      setState(() {
                        usernameError = responseData['username'] != null
                            ? responseData['username'][0]
                            : '';
                        phoneError = responseData['phone_number'] != null
                            ? responseData['phone_number'][0]
                            : '';
                        passwordError = responseData['password'] != null
                            ? responseData['password'][0]
                            : '';
                        confirmPasswordError =
                            responseData['confirm_password'] != null
                                ? responseData['confirm_password'][0]
                                : '';
                      });
                    }
                  },
                  child: Text('Register'),
                ),
                SizedBox(height: 10.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(width: 5.0),
                      Text('Already have an account? Login'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String labelText,
      IconData prefixIcon, String errorText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon, color: Colors.white),
        border: OutlineInputBorder(),
        errorText: errorText.isNotEmpty ? errorText : null,
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String labelText,
      IconData prefixIcon, String errorText) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon, color: Colors.white),
        border: OutlineInputBorder(),
        errorText: errorText.isNotEmpty ? errorText : null,
      ),
    );
  }
}
