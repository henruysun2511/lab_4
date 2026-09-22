import 'package:flutter_test/flutter_test.dart';
import 'package:lab4_ui_fundamentals/main.dart';

void main() {
  testWidgets('Lab 4 Main Dashboard smoke test', (WidgetTester tester) async {
    // Build Lab4MainApp and trigger a frame.
    await tester.pumpWidget(const Lab4MainApp());

    // Verify title is rendered
    expect(find.text('Lab 4: Flutter UI Fundamentals'), findsOneWidget);

    // Verify all 5 exercises are listed
    expect(find.text('Core Widgets'), findsOneWidget);
    expect(find.text('Input Widgets'), findsOneWidget);
    expect(find.text('Layout Composition'), findsOneWidget);
    expect(find.text('Scaffold & Theme'), findsOneWidget);
    expect(find.text('Debug & Fix UI Errors'), findsOneWidget);
  });
}
