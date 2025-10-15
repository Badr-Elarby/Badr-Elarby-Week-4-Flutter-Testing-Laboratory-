import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/user_registration_form.dart';

void main() {
  // التيستات اللي هتتحقق من الواجهة
  testWidgets('User Registration Form Widget Tests', (
    WidgetTester tester,
  ) async {
    // بننشئ الـ Widget ونضيفه للاختبار
    await tester.pumpWidget(const MaterialApp(home: UserRegistrationForm()));

    // 1. تحقق من رسالة الخطأ لـ email غير صحيح
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'a@',
    ); // الحقل الثاني (Email)
    await tester.tap(find.text('Register'));
    await tester.pump();

    expect(find.text('Please enter a valid email'), findsOneWidget);

    // 2. تحقق من رسالة الخطأ لـ password ضعيف
    await tester.enterText(
      find.byType(TextFormField).at(2),
      'weak',
    ); // الحقل الثالث (Password)
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
    ); // الحقل الأول (Name)
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'test@domain.com',
    ); // Email
    await tester.enterText(
      find.byType(TextFormField).at(2),
      'Password123!',
    ); // Password
    await tester.enterText(
      find.byType(TextFormField).at(3),
      'Password123!',
    ); // Confirm Password
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle(
      const Duration(seconds: 2),
    ); // ننتظر 2 ثانية لـ API simulation

    expect(find.text('Registration successful!'), findsOneWidget);
  });
}
