import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:zm_technology/main.dart';
import 'package:zm_technology/providers/product_provider.dart';

void main() {
  testWidgets('La aplicación ZM TECHNOLOGY inicia correctamente',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ProductProvider(),
        child: const ZmApp(),
      ),
    );

    expect(find.text('ZM TECHNOLOGY'), findsWidgets);
    expect(find.text('Inicio'), findsOneWidget);
    expect(find.text('Catálogo'), findsOneWidget);
  });
}
