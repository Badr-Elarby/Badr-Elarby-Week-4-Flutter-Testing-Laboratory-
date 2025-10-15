import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/weather_display.dart';

void main() {
  testWidgets('WeatherDisplay UI elements test', (WidgetTester tester) async {
    // 1️⃣ نغلف الـ widget في MaterialApp علشان Dropdown و Switch يشتغلوا
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: WeatherDisplay())),
    );

    // 2️⃣ نتأكد إن الـ Dropdown موجود
    expect(find.byType(DropdownButton<String>), findsOneWidget);

    // 3️⃣ نتأكد إن Dropdown فيه "New York" بس بطريقة دقيقة
    expect(
      find.descendant(
        of: find.byType(DropdownButton<String>),
        matching: find.text('New York'),
      ),
      findsOneWidget,
    );

    // 4️⃣ نتأكد إن Switch موجود
    expect(find.byType(Switch), findsOneWidget);

    // 5️⃣ نتأكد من وجود زر Refresh
    expect(find.widgetWithText(ElevatedButton, 'Refresh'), findsOneWidget);

    // 6️⃣ ننتظر الـ API simulation (2 ثانية)
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    // 7️⃣ بعد التحميل، نتأكد إن Card ظهر
    expect(find.byType(Card), findsOneWidget);

    // 8️⃣ نتأكد إن النص الخاص بالمدينة ظهر داخل الـ Card
    expect(
      find.descendant(of: find.byType(Card), matching: find.text('New York')),
      findsOneWidget,
    );

    // 9️⃣ نتأكد من وجود أيقونات وملفات الطقس
    expect(find.byIcon(Icons.water_drop), findsOneWidget);
    expect(find.byIcon(Icons.air), findsOneWidget);
  });
}
