import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test_tutorial/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    "check if not inputting any text and proceeding gives error",
    (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.byType(TypingPage), findsOneWidget);
      expect(find.byType(DisplayPage), findsNothing);
      expect(find.text("Input at least one character"), findsOneWidget);
    },
  );

  testWidgets(
    "Inputted Text should be displayed upon pressing the button",
    (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField), "Raunak");
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.byType(TypingPage), findsNothing);
      expect(find.byType(DisplayPage), findsOneWidget);
      expect(find.text("Raunak"), findsOneWidget);

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      expect(find.byType(TypingPage), findsOneWidget);
      expect(find.byType(DisplayPage), findsNothing);
      expect(find.text("Raunak"), findsNothing);

    },
  );
}
