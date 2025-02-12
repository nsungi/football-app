import 'package:flutter/material.dart';

class LogoutScreen extends StatefulWidget {
  @override
  _LogoutScreenState createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  // Implement Logout Logic here
  Future<void> logout() async {
    // Perform any necessary cleanup or actions on logout
    // For example, clear user tokens, navigate to the login screen, etc.

    // For demonstration purposes, let's navigate back to the login screen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logout'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Implement your Logout Logic here'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: logout,
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
