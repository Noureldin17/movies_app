import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:movies_app/utils/default_text.dart';
import 'utils/colors.dart' as colors;
import 'utils/pages.dart' as pages;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primaryDark,
      body: Center(
        child: Column(
          children: [
            const DefaultText.bold(text: "HOME PAGE", fontSize: 28),
            ElevatedButton(
                onPressed: (() {
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(LogoutEvent());
                }),
                child: Text('Logout')),
            BlocListener<AuthenticationBloc, AuthenticationState>(
              listenWhen: (previous, current) => current is LogoutSuccessState,
              listener: (context, state) {
                Navigator.pushReplacementNamed(context, pages.welcomePage);
              },
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
