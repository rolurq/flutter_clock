// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import 'package:chronus_clock/simple_clock.dart';

void main() {
  final clock = ClockModel()..is24HourFormat = true;

  testWidgets('Time format change test', (WidgetTester tester) async {
    // Build the clock widget.
    await tester.pumpWidget(MaterialApp(home: SimpleClock(clock)));

    DateTime now = DateTime.now();
    // Verify that the current time is in 24h format
    expect(find.text(DateFormat('HH:mm').format(now)), findsOneWidget);

    clock.is24HourFormat = false;
    await tester.pump();
    now = DateTime.now();

    // Verify that the clock has changed time format
    expect(find.text(DateFormat('HH:mm').format(now)), findsNothing);
    expect(find.text(DateFormat('hh:mm').format(now)), findsOneWidget);
  });
}
