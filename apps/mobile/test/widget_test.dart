// Test de humo del home screen de LicitaNext.
import 'package:flutter_test/flutter_test.dart';

import 'package:licitanext/main.dart';

void main() {
  testWidgets('Home screen muestra el branding de LicitaNext', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const LicitaNextApp());

    expect(find.text('LicitaNext'), findsOneWidget);
    expect(find.text('Agente cazador de licitaciones'), findsOneWidget);
  });
}
