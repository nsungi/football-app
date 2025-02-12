import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:site/main.dart';

void main() {
  testWidgets('Authentication screen UI test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify the presence of certain UI elements on the Authentication screen.
    expect(find.text('Authentication Example'), findsOneWidget);
    expect(find.byType(ElevatedButton),
        findsNWidgets(2)); // Two ElevatedButtons for Sign Up and Login

    // You may add more UI verification based on your actual app structure.
  });
}
