import 'package:flutter_test/flutter_test.dart';
import 'package:facartes_movil/main.dart';

void main() {
  testWidgets('muestra la galería al iniciar', (tester) async {
    await tester.pumpWidget(const FacartesApp());
    expect(find.text('FACARTES Móvil'), findsOneWidget);
    expect(find.text('Para ti ✨'), findsOneWidget);
  });

  testWidgets('navega al asistente y a subir obra', (tester) async {
    await tester.pumpWidget(const FacartesApp());
    await tester.tap(find.text('Asistente'));
    await tester.pumpAndSettle();
    expect(find.text('Asistente FACARTES'), findsOneWidget);
    await tester.tap(find.text('Subir'));
    await tester.pumpAndSettle();
    expect(find.text('Tomar foto'), findsOneWidget);
  });
}
