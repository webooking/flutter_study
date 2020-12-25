import 'package:flutter/material.dart';
import 'package:flutter_study/screen/counter/counter_screen.dart';
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

  testWidgets('sharing data between multi screens', (tester) async {
    await tester.pumpWidget(GetMaterialApp(home: CounterScreen()));

    expect(_findByKey(tester, 'ParentScreenText').data, '0');

    await _tapFloatingActionButton(tester);
    expect(_findByKey(tester, 'ParentScreenText').data, '1');

    await _tapRaisedButton(tester);//Navigate to ChildScreen
    expect(_findByKey(tester, 'ChildScreenText').data, '1');

    await _tapFloatingActionButton(tester);
    await _tapFloatingActionButton(tester);
    expect(_findByKey(tester, 'ChildScreenText').data, '-1');

    await _tapRaisedButton(tester);//Navigate to ParentScreen
    expect(_findByKey(tester, 'ParentScreenText').data, '-1');
  });
}

Future<void> _tapByType(WidgetTester tester, Type type) async {
  final button = find.byType(type);
  await tester.tap(button);
  await tester.pumpAndSettle();
}

Future<void> _tapRaisedButton(WidgetTester tester) async => _tapByType(tester, RaisedButton);

Future<void> _tapFloatingActionButton(WidgetTester tester) async => _tapByType(tester, FloatingActionButton);

Text _findByKey(WidgetTester tester, String key) => tester.widget<Text>(find.byKey(ValueKey(key)));

Offset _rightEdgeOfFab(WidgetTester tester) {
  final fab = find.byType(FloatingActionButton);
  return tester.getRect(fab).centerRight - const Offset(1.0, 0.0);
}
