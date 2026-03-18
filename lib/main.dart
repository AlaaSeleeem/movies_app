import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/cache/cache_helper.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/data/data_source/auth_firebase_data_source.dart';
import 'features/auth/data/repositories_impl/auth_repository_impl.dart';
import 'features/auth/domian/repositories/auth_repository.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/home/data/data_source/home_remote_data_source.dart';
import 'features/home/data/repositories_impl/home_repository_impl.dart';
import 'features/home/domain/use_cases/get_movies_use_case.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/home/presentation/bloc/home_event.dart';
import 'features/browse/presentation/screens/browse_screen.dart';
import 'features/splash/presentation/screens/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  await CacheHelper.init();


  final AuthFirebaseDataSource authDataSource = AuthFirebaseDataSource();
  final AuthRepository authRepository = AuthRepositoryImpl(authDataSource);
  final HomeRemoteDataSource homeDataSource = HomeRemoteDataSourceImpl();
  final HomeRepositoryImpl homeRepository = HomeRepositoryImpl(homeDataSource);
  final GetMoviesUseCase getMoviesUseCase = GetMoviesUseCase(homeRepository);

  runApp(MyApp(
    authRepository: authRepository,
    getMoviesUseCase: getMoviesUseCase,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final GetMoviesUseCase getMoviesUseCase;

  const MyApp({
    super.key,
    required this.authRepository,
    required this.getMoviesUseCase,
  });

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (_) => AuthBloc(authRepository),
        ),

        BlocProvider(
          create: (_) => HomeBloc(getMoviesUseCase)..add(GetMoviesEvent()),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Route Movies App',
            theme: AppTheme.darkTheme,
            initialRoute: SplashScreen.routeName,
            onGenerateRoute: AppRouter.generateRoute,
          );
        },
      ),
    );
  }
}