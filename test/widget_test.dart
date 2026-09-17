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

    expect(find.text('Your session'), findsOneWidget);
    expect(find.text('Choose a scene'), findsOneWidget);
  });
}