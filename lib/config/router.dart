import 'package:flutter/material.dart';
import 'package:movies_app/features/authentication/presentation/pages/login_page.dart';
import 'package:movies_app/features/authentication/presentation/pages/welcome_page.dart';
import 'package:movies_app/home_page.dart';
import '../utils/pages.dart' as pages;

class AppRouter {
  late Widget startScreen;

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case pages.welcomePage:
        return MaterialPageRoute(
          builder: (context) => const WelcomePage(),
        );
      case pages.loginPage:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case pages.homePage:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      default:
        return null;
    }
  }
}
