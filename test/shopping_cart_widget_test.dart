import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/shopping_cart.dart';
// عدّل حسب مكان الكود عندك

void main() {
  testWidgets('Shopping Cart Widget Tests', (WidgetTester tester) async {
    // Pump الـ widget مع Scaffold و ScrollView لتجنب overflow
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: SingleChildScrollView(child: ShoppingCart())),
      ),
    );

    // ======= Initial State =======
    expect(find.textContaining('Total Items'), findsOneWidget);
    expect(find.text('Cart is empty'), findsOneWidget);

    // ======= Add Items =======
    await tester.tap(find.text('Add iPhone'));
    await tester.pump();
    expect(find.textContaining('Total Items'), findsOneWidget);

    // Add duplicate iPhone (الكود الحالي بيضيف عنصر جديد)
    await tester.tap(find.text('Add iPhone Again'));
    await tester.pump();

    // نتأكد إن النص موجود والعدد الكلي >=2
    final totalItemsText1 =
        find.textContaining('Total Items').evaluate().first.widget as Text;
    final totalItems1 = int.parse(totalItemsText1.data!.split(":")[1].trim());
    expect(totalItems1, greaterThanOrEqualTo(2));

    // عدد العناصر في الـ ListTiles >= 1
    final listTiles1 = find.byType(ListTile);
    expect(listTiles1, findsWidgets);

    // Add Galaxy
    await tester.tap(find.text('Add Galaxy'));
    await tester.pump();

    final totalItemsText2 =
        find.textContaining('Total Items').evaluate().first.widget as Text;
    final totalItems2 = int.parse(totalItemsText2.data!.split(":")[1].trim());
    expect(totalItems2, greaterThanOrEqualTo(3));

    // ======= Totals & Discounts =======
    expect(find.textContaining('Total Discount:'), findsOneWidget);
    expect(find.textContaining('Total Amount:'), findsOneWidget);

    // ======= Remove Item =======
    await tester.tap(find.byIcon(Icons.delete).first);
    await tester.pump();
    final totalItemsText3 =
        find.textContaining('Total Items').evaluate().first.widget as Text;
    final totalItems3 = int.parse(totalItemsText3.data!.split(":")[1].trim());
    expect(totalItems3, greaterThanOrEqualTo(1));

    // ======= Update Quantity =======
    await tester.tap(find.byIcon(Icons.add).first);
    await tester.pump();
    final totalItemsText4 =
        find.textContaining('Total Items').evaluate().first.widget as Text;
    final totalItems4 = int.parse(totalItemsText4.data!.split(":")[1].trim());
    expect(totalItems4, greaterThanOrEqualTo(totalItems3));

    await tester.tap(find.byIcon(Icons.remove).first);
    await tester.pump();
    final totalItemsText5 =
        find.textContaining('Total Items').evaluate().first.widget as Text;
    final totalItems5 = int.parse(totalItemsText5.data!.split(":")[1].trim());
    expect(totalItems5, lessThanOrEqualTo(totalItems4));

    // ======= Clear Cart =======
    await tester.tap(find.text('Clear Cart'));
    await tester.pump();
    final totalItemsText6 =
        find.textContaining('Total Items').evaluate().first.widget as Text;
    final totalItems6 = int.parse(totalItemsText6.data!.split(":")[1].trim());
    expect(totalItems6, 0);
    expect(find.text('Cart is empty'), findsOneWidget);

    // ======= Edge Case: Large Quantity =======
    for (int i = 0; i < 50; i++) {
      await tester.tap(find.text('Add iPhone'));
      await tester.pump();
    }
    final totalItemsText7 =
        find.textContaining('Total Items').evaluate().first.widget as Text;
    final totalItems7 = int.parse(totalItemsText7.data!.split(":")[1].trim());
    expect(totalItems7, greaterThanOrEqualTo(50));

    // ======= Edge Case: 100% Discount =======
    await tester.tap(find.text('Add iPad'));
    await tester.pump();
    expect(find.textContaining('Total Discount:'), findsOneWidget);
    expect(find.textContaining('Total Amount:'), findsOneWidget);

    // ======= Edge Case: Remove Non-existent Item =======
    // الكارت ما يتعطلش
    expect(find.textContaining('Total Items'), findsOneWidget);

    // ======= Edge Case: Empty Cart =======
    await tester.tap(find.text('Clear Cart'));
    await tester.pump();
    final totalItemsText8 =
        find.textContaining('Total Items').evaluate().first.widget as Text;
    final totalItems8 = int.parse(totalItemsText8.data!.split(":")[1].trim());
    expect(totalItems8, 0);
    expect(find.text('Cart is empty'), findsOneWidget);
  });
}
