import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:helloworld/task2/grade_calculator_app.dart';

void main() {
  testWidgets('shows an error when grade fields are empty', (tester) async {
    await tester.pumpWidget(const GradeCalculatorApp());

    expect(find.byType(TextField), findsNWidgets(3));

    await tester.tap(find.text('Calculate Average'));
    await tester.pump();

    expect(find.text('Please enter all three grades.'), findsOneWidget);
  });

  testWidgets('shows an error when a grade is not a number', (tester) async {
    await tester.pumpWidget(const GradeCalculatorApp());

    final gradeFields = find.byType(TextField);
    await tester.enterText(gradeFields.at(0), '80');
    await tester.enterText(gradeFields.at(1), 'not a number');
    await tester.enterText(gradeFields.at(2), '70');
    await tester.tap(find.text('Calculate Average'));
    await tester.pump();

    expect(
      find.text('Please enter valid numbers for all grades.'),
      findsOneWidget,
    );
  });

  testWidgets('calculates and displays a passing average', (tester) async {
    await tester.pumpWidget(const GradeCalculatorApp());

    final gradeFields = find.byType(TextField);
    await tester.enterText(gradeFields.at(0), '80');
    await tester.enterText(gradeFields.at(1), '70');
    await tester.enterText(gradeFields.at(2), '60');
    await tester.tap(find.text('Calculate Average'));
    await tester.pump();

    expect(find.text('70.00'), findsOneWidget);
    expect(find.text('Kalon'), findsOneWidget);
  });

  testWidgets('calculates and displays a low average', (tester) async {
    await tester.pumpWidget(const GradeCalculatorApp());

    final gradeFields = find.byType(TextField);
    await tester.enterText(gradeFields.at(0), '40');
    await tester.enterText(gradeFields.at(1), '45');
    await tester.enterText(gradeFields.at(2), '35');
    await tester.tap(find.text('Calculate Average'));
    await tester.pump();

    expect(find.text('40.00'), findsOneWidget);
    expect(find.text('Duhet përmirësim'), findsOneWidget);
  });
}
