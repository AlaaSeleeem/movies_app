import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:movies_app/main.dart';
import 'package:movies_app/features/auth/data/data_source/auth_firebase_data_source.dart';
import 'package:movies_app/features/auth/data/repositories_impl/auth_repository_impl.dart';
import 'package:movies_app/features/home/data/data_source/home_remote_data_source.dart';
import 'package:movies_app/features/home/data/repositories_impl/home_repository_impl.dart';
import 'package:movies_app/features/home/domain/use_cases/get_movies_use_case.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    final authRepository = AuthRepositoryImpl(AuthFirebaseDataSource());
    final homeRepository = HomeRepositoryImpl(HomeRemoteDataSourceImpl());
    final getMoviesUseCase = GetMoviesUseCase(homeRepository);

    await tester.pumpWidget(MyApp(
      authRepository: authRepository,
      getMoviesUseCase: getMoviesUseCase,
    ));
  });
}