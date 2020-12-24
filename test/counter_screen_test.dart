import 'package:flutter/material.dart';
import 'package:flutter_study/screen/counter_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  testWidgets('appBar text', (tester) async {
    await tester.pumpWidget(GetMaterialApp(home: CounterScreen()));

    expect(find.textContaining('Click'), findsOneWidget);
    expect(find.textContaining('Clicks: '), findsOneWidget);
  });

  testWidgets('tap floatingActionButton', (tester) async {
    await tester.pumpWidget(GetMaterialApp(home: CounterScreen()));

    expect(find.byTooltip('Increment'), findsOneWidget);
    final button = tester.widget<FloatingActionButton>(find.byType(FloatingActionButton));
    button.onPressed();
  });

  testWidgets('long press', (tester) async {
    await tester.pumpWidget(GetMaterialApp(home: CounterScreen()));

    expect(find.text('Increment'), findsNothing);

    await tester.longPressAt(_rightEdgeOfFab(tester));
    await tester.pumpAndSettle();
    expect(find.text('Increment'), findsOneWidget);
  });

  testWidgets('tap & observable count.value', (tester) async {
    await tester.pumpWidget(GetMaterialApp(home: CounterScreen()));

    expect(find.text('Clicks: 0'), findsOneWidget);

    final fab = find.byType(FloatingActionButton);
    await tester.tap(fab);
    await tester.pumpAndSettle();
    expect(find.text('Clicks: 1'), findsOneWidget);
  });
}
Offset _rightEdgeOfFab(WidgetTester tester) {
  final fab = find.byType(FloatingActionButton);
  return tester.getRect(fab).centerRight - const Offset(1.0, 0.0);
}