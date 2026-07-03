// Basic smoke test for the education app.
//
// We verify the app boots and shows the login screen with its main building
// blocks (title + login button).

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:education_project_example/main.dart';

void main() {
  testWidgets('App boots and shows the login screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const EducationApp());

    // The login screen header title.
    expect(find.text('Welcome back'), findsOneWidget);

    // The login button.
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);

    // The role toggle shows both roles.
    expect(find.text('Student'), findsWidgets);
    expect(find.text('Teacher'), findsWidgets);
  });
}
