import 'package:flutter/material.dart';
import 'package:movies_app/utils/default_text.dart';
import 'utils/colors.dart' as colors;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: colors.primaryDark,
      body: Center(
        child: DefaultText.bold(text: "HOME PAGE", fontSize: 28),
      ),
    );
  }
}
