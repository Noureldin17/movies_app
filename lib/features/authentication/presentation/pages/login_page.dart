import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:movies_app/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:movies_app/features/authentication/presentation/widgets/gradient_button.dart';
import 'package:movies_app/utils/default_text.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/colors.dart' as colors;
import '../../../../utils/pages.dart' as pages;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passwordHidden = true;
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: colors.primaryDark,
          centerTitle: true,
          title: const DefaultText.bold(text: "Login", fontSize: 18),
        ),
        backgroundColor: colors.primaryDark,
        body: Column(
          children: [
            Form(
                key: formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 50.sp, left: 10.sp, right: 10.sp),
                      child: TextFormField(
                        controller: usernameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            focusedBorder: GradientOutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.sp),
                                gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      colors.primaryBlue,
                                      colors.primaryPurple
                                    ])),
                            border: GradientOutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.sp),
                                gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      colors.primaryBlue,
                                      colors.primaryPurple
                                    ])),
                            labelStyle: const TextStyle(
                              color: colors.primaryGrey,
                            ),
                            labelText: "Username",
                            hintStyle: const TextStyle(
                              color: colors.primaryGrey,
                            ),
                            hintText: "Enter your username"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 20.sp, left: 10.sp, right: 10.sp),
                      child: TextFormField(
                        controller: passwordController,
                        style: const TextStyle(color: Colors.white),
                        obscureText: passwordHidden,
                        decoration: InputDecoration(
                            suffixIcon: passwordHidden
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        passwordHidden = !passwordHidden;
                                      });
                                    },
                                    icon: SvgPicture.asset(
                                      'assets/icons/eye.svg',
                                      color: colors.primaryGrey,
                                    ))
                                : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        passwordHidden = !passwordHidden;
                                      });
                                    },
                                    icon: SvgPicture.asset(
                                      'assets/icons/eye-slash.svg',
                                      color: colors.primaryGrey,
                                    )),
                            focusedBorder: GradientOutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.sp),
                                gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      colors.primaryBlue,
                                      colors.primaryPurple
                                    ])),
                            border: GradientOutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.sp),
                                gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      colors.primaryBlue,
                                      colors.primaryPurple
                                    ])),
                            labelStyle: const TextStyle(
                              color: colors.primaryGrey,
                            ),
                            labelText: "Password",
                            hintStyle: const TextStyle(
                              color: colors.primaryGrey,
                            ),
                            hintText: "Enter your password"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.sp, right: 12.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "Forgot Password?",
                              style: GoogleFonts.roboto(
                                color: colors.primaryGrey,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 30.sp)),
                    GradientButton(
                        onButtonPressed: () {
                          BlocProvider.of<AuthenticationBloc>(context).add(
                              LoginEvent(usernameController.text,
                                  passwordController.text));
                        },
                        buttonText: "Login"),
                    BlocConsumer<AuthenticationBloc, AuthenticationState>(
                      builder: (context, state) {
                        if (state is LoginErrorState) {
                          return const DefaultText.bold(
                              text: 'Login Failed', fontSize: 16);
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                      listenWhen: (previous, current) =>
                          current is LoginSuccessState,
                      listener: (context, state) {
                        Navigator.pushNamed(context, pages.homePage);
                      },
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
