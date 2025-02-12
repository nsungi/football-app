import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:football/main.dart';

void main() {
  testWidgets('App should display correct title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the app displays the correct title.
    expect(find.text('User Authentication'), findsOneWidget);
  });
}
