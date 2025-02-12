import 'package:flutter/material.dart';
import 'signup.dart';
import 'login.dart';
import 'logout.dart';
import 'auth_service.dart';

class AuthScreen extends StatelessWidget {
  final AuthService authService =
      AuthService('YOUR_BASE_URL'); // Replace with your actual base URL

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: authService.isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          bool isLoggedIn = snapshot.data ?? false;

          return Scaffold(
            appBar: AppBar(
              title: Text('Application'),
              actions: [
                isLoggedIn
                    ? IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LogoutScreen(),
                            ),
                          );
                        },
                        icon: Icon(Icons.logout),
                      )
                    : SizedBox.shrink(),
              ],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                    },
                    child: Text('Sign Up'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
