import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/user_registration_form.dart';

void main() {
  group('User Registration Form Validation Tests', () {
    late State<UserRegistrationForm> state;

    setUp(() {
      final widget = UserRegistrationForm();
      state = widget.createState();
    });

    // Email validation tests
    test('Valid email returns true based on current regex', () {
      expect((state as dynamic).isValidEmail('test@domain.com'), true);
      expect((state as dynamic).isValidEmail('user@domain.co'), true);
      expect((state as dynamic).isValidEmail('user.name@domain.com'), true);
    });

    test('Invalid email returns false', () {
      expect((state as dynamic).isValidEmail('a@'), false); // No domain
      expect((state as dynamic).isValidEmail('@b'), false); // No username
      expect((state as dynamic).isValidEmail(''), false); // Empty
      expect((state as dynamic).isValidEmail('not_an_email'), false); // No @
      expect((state as dynamic).isValidEmail('test@domain'), false); // No TLD
      expect(
        (state as dynamic).isValidEmail('test+label@domain.com'),
        false,
      ); // + not fully supported
    });

    // Password validation tests
    test('Valid password returns true', () {
      expect((state as dynamic).isValidPassword('Password123!'), true);
      expect((state as dynamic).isValidPassword('Abcd1234@'), true);
      expect((state as dynamic).isValidPassword('Test#9876'), true);
    });

    test('Invalid password returns false', () {
      expect((state as dynamic).isValidPassword('weak'), false); // Too short
      expect(
        (state as dynamic).isValidPassword('nopassword123'),
        false,
      ); // No uppercase
      expect(
        (state as dynamic).isValidPassword('NOPASSWORD123!'),
        false,
      ); // No lowercase
      expect(
        (state as dynamic).isValidPassword('NoSpecial123'),
        false,
      ); // No special char
      expect(
        (state as dynamic).isValidPassword('NoDigits!abc'),
        false,
      ); // No digits
      expect((state as dynamic).isValidPassword(''), false); // Empty
    });
  });
}
