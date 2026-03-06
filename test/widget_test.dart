import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:movies_app/main.dart';
import 'package:movies_app/features/auth/data/data_source/auth_firebase_data_source.dart';
import 'package:movies_app/features/auth/data/repositories_impl/auth_repository_impl.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    final repository = AuthRepositoryImpl(AuthFirebaseDataSource());
    await tester.pumpWidget(MyApp(repository: repository));

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}