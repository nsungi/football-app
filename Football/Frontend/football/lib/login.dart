import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'register.dart';
import 'success.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                _buildInputField(phoneController, 'Phone Number', Icons.phone),
                SizedBox(height: 10.0),
                _buildPasswordField(passwordController, 'Password', Icons.lock),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    var response = await http.post(
                      Uri.parse('http://192.168.1.115:8000/api/main/login/'),
                      body: {
                        'phone_number': phoneController.text,
                        'password': passwordController.text,
                      },
                    );

                    if (response.statusCode == 200) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SuccessScreen()),
                      );
                    } else {
                      var responseData = json.decode(response.body);
                      var errorMessage = responseData['error'];
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(errorMessage),
                          backgroundColor: Colors.red, // Error message color
                        ),
                      );
                    }
                  },
                  child: Text('Login'),
                ),
                SizedBox(height: 10.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_add),
                      SizedBox(width: 5.0),
                      Text('Don\'t have an account? Register'),
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

  Widget _buildInputField(
      TextEditingController controller, String labelText, IconData prefixIcon) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon, color: Colors.white),
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildPasswordField(
      TextEditingController controller, String labelText, IconData prefixIcon) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon, color: Colors.white),
        border: OutlineInputBorder(),
      ),
    );
  }
}
