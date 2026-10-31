import 'package:flutter_test/flutter_test.dart';

import 'package:product_app/main.dart';

void main() {
  testWidgets('Home screen displays its title and search field',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Temukan Produk'), findsOneWidget);
    expect(find.text('Cari produk...'), findsOneWidget);
  });
}
