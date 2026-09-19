import 'package:flutter_test/flutter_test.dart';

import 'package:final_project/main.dart';

void main() {
  testWidgets('Drift welcome screen shows its welcome message', (tester) async {
    await tester.pumpWidget(const DriftApp());

    expect(find.text('Welcome to Drift'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });

  testWidgets('Get Started navigates to the home screen', (tester) async {
    await tester.pumpWidget(const DriftApp());

    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    expect(find.text('Polaroids of Summer'), findsOneWidget);
    expect(find.text('Working'), findsOneWidget);
    expect(find.text('1/4'), findsOneWidget);
  });
}