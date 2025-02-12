import 'package:flutter/material.dart';
//import 'success.dart';
import 'video_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Authentication',
      theme: ThemeData(
        primaryColor: Colors.blue,
        hintColor: Colors.green,
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        // '/': (context) => SuccessScreen(),
        // '/upload-form': (context) => UploadFormPage(),
        // '/success': (context) => SuccessScreen(),
      },
    );
  }
}
