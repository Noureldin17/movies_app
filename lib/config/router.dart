import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/authentication/presentation/pages/login_page.dart';
import 'package:movies_app/features/authentication/presentation/pages/onboarding.dart';
import 'package:movies_app/features/authentication/presentation/pages/welcome_page.dart';
import 'package:movies_app/app_main_page.dart';
import 'package:movies_app/features/movies/domain/models/movie_detail_args_model.dart';
import 'package:movies_app/features/movies/domain/models/movie_model.dart';
import 'package:movies_app/features/movies/presentation/pages/movie_detail_page.dart';
import '../features/authentication/presentation/bloc/authentication_bloc.dart';
import '../features/movies/presentation/bloc/movies_bloc.dart';
import '../utils/pages.dart' as pages;
import '../core/dependency_injection/dependency_injection.dart' as di;

class AppRouter {
  late Widget startScreen;

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case pages.welcomePage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => di.sl<AuthenticationBloc>(),
            child: const WelcomePage(),
          ),
        );
      case pages.onBoardingPage:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingPage(),
        );
      case pages.loginPage:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => di.sl<AuthenticationBloc>(),
            child: const LoginPage(),
          ),
        );
      case pages.appMainPage:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => di.sl<MoviesBloc>(),
              ),
            ],
            child: const AppMainPage(),
          ),
        );
      case pages.movieDetailPage:
        return MaterialPageRoute(
          builder: (context) => MovieDetailPage(
              movieDetailArgs: settings.arguments as MovieDetailArgs),
        );
      default:
        return null;
    }
  }
}
