// test/weather_utils_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/weather_display.dart';
// عدّل path على حسب مشروعك

void main() {
  group('Temperature Conversion Tests', () {
    test('Celsius to Fahrenheit', () {
      expect(celsiusToFahrenheit(0), 32);
      expect(celsiusToFahrenheit(100), 212);
      expect(celsiusToFahrenheit(-40), -40);
      expect(celsiusToFahrenheit(37), closeTo(98.6, 0.1));
    });

    test('Fahrenheit to Celsius', () {
      expect(fahrenheitToCelsius(32), 0);
      expect(fahrenheitToCelsius(212), 100);
      expect(fahrenheitToCelsius(-40), -40);
      expect(fahrenheitToCelsius(98.6), closeTo(37, 0.1));
    });
  });
}
