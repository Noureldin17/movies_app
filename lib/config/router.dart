import 'package:flutter/material.dart';
import 'package:movies_app/features/authentication/presentation/pages/welcome_page.dart';
import '../utils/pages.dart' as pages;

class AppRouter {
  late Widget startScreen;

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case pages.welcomePage:
        return MaterialPageRoute(
          builder: (context) => const WelcomePage(),
        );
      default:
        return null;
    }
  }
}
