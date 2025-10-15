import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/user_registration_form.dart';

void main() {
  testWidgets('User Registration Form Widget Tests', (
    WidgetTester tester,
  ) async {
    // بننشئ الـ Widget مع Scaffold وMaterialApp
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: UserRegistrationForm())),
    );

    // 1. تحقق من رسالة الخطأ لـ email غير صحيح
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'a@',
    ); // Email field
    await tester.tap(find.text('Register'));
    await tester.pump();

    expect(find.text('Please enter a valid email'), findsOneWidget);

    // 2. تحقق من رسالة الخطأ لـ password ضعيف
    await tester.enterText(
      find.byType(TextFormField).at(2),
      'weak',
    ); // Password field
    await tester.tap(find.text('Register'));
    await tester.pump();

    expect(
      find.text(
        'Password must be at least 8 characters, including an uppercase letter, a lowercase letter, a number, and a special character',
      ),
      findsOneWidget,
    );

    // 3. تحقق من رسالة النجاح لـ بيانات صحيحة
    await tester.enterText(
      find.byType(TextFormField).at(0),
      'John Doe',
    ); // Name field
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'test@domain.com',
    ); // Email field
    await tester.enterText(
      find.byType(TextFormField).at(2),
      'Password123!',
    ); // Password field
    await tester.enterText(
      find.byType(TextFormField).at(3),
      'Password123!',
    ); // Confirm Password field
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle(
      const Duration(seconds: 2),
    ); // ننتظر 2 ثانية لـ API simulation

    expect(find.text('Registration successful!'), findsOneWidget);
  });
}
