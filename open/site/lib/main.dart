import 'package:flutter/material.dart';
import 'auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthScreen(),
      debugShowCheckedModeBanner:
          false, // Set this to false to remove the debug banner
    );
  }
}
