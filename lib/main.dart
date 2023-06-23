import 'dart:ui';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/config/router.dart';
import 'package:movies_app/features/authentication/presentation/pages/onboarding.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import './utils/colors.dart' as colors;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AppRouter router = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.onGenerateRoute,
      home: Sizer(
        builder: (context, orientation, deviceType) => AnimatedSplashScreen(
            splashIconSize: 200.sp,
            animationDuration: const Duration(milliseconds: 500),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.fade,
            backgroundColor: colors.primaryDark,
            splash: splashScreen(),
            nextScreen: const OnBoardingPage()),
      ),
    );
  }
}

Widget splashScreen() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
                  colors: [colors.primaryBlue, colors.primaryPurple])
              .createShader(bounds),
          child: Image.asset(
            'assets/logo/film.png',
            width: 90.sp,
            height: 90.sp,
          )),
      Padding(padding: EdgeInsets.all(10.sp)),
      RichText(
          text: TextSpan(children: [
        TextSpan(
          text: "Movie",
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
        TextSpan(
          text: "Magic",
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        )
      ]))
    ],
  );
}
