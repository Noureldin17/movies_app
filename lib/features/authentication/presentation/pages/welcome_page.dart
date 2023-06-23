import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/features/authentication/presentation/widgets/custom_outline.dart';
import 'package:movies_app/utils/default_text.dart';
import '../../../../utils/colors.dart' as colors;
import 'package:sizer/sizer.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => Scaffold(
        backgroundColor: colors.primaryDark,
        body: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 110.sp),
                  child: ClipPath(
                    clipBehavior: Clip.hardEdge,
                    clipper: DiagonalPathClipperTwo(),
                    child: Container(
                      padding: EdgeInsets.only(top: 50.sp),
                      width: 100.w,
                      height: 200.sp,
                      child: Image.asset(
                        'assets/posters/welcome1.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 80.sp),
                  child: ClipPath(
                    clipper: DiagonalPathClipperTwo(),
                    child: Container(
                      width: 100.w,
                      height: 130.sp,
                      color: colors.primaryDark,
                    ),
                  ),
                ),
                ClipPath(
                  clipBehavior: Clip.hardEdge,
                  clipper: DiagonalPathClipperTwo(),
                  child: Container(
                    padding: EdgeInsets.only(top: 50.sp),
                    width: 100.w,
                    height: 200.sp,
                    child: Image.asset(
                      'assets/posters/welcome2.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                ClipPath(
                  clipper: DiagonalPathClipperTwo(),
                  child: Container(
                    width: 100.w,
                    height: 100.sp,
                    color: colors.primaryDark,
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 30.sp)),
            const DefaultText.bold(text: "Welcome!", fontSize: 26),
            Padding(padding: EdgeInsets.only(top: 20.sp)),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(8.sp),
                gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [colors.primaryBlue, colors.primaryPurple]),
              ),
              child: UnicornOutlineButton(
                gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color.fromARGB(255, 167, 204, 241),
                      Color.fromARGB(255, 193, 152, 207)
                    ]),
                onPressed: () {},
                radius: 8.sp,
                strokeWidth: 1.sp,
                child: ElevatedButton(
                  onPressed: (() {}),
                  style: ElevatedButton.styleFrom(
                      elevation: 4.sp,
                      shadowColor: Colors.transparent,
                      fixedSize: Size(250.sp, 35.sp),
                      padding: EdgeInsets.all(0.sp),
                      backgroundColor: Colors.transparent),
                  child: const DefaultText.bold(text: "Register", fontSize: 14),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.sp)),
            UnicornOutlineButton(
              gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [colors.primaryBlue, colors.primaryPurple]),
              onPressed: () {},
              radius: 8.sp,
              strokeWidth: 2.sp,
              child: ElevatedButton(
                onPressed: (() {}),
                style: ElevatedButton.styleFrom(
                    elevation: 4.sp,
                    shadowColor: Colors.transparent,
                    fixedSize: Size(250.sp, 35.sp),
                    padding: EdgeInsets.all(0.sp),
                    backgroundColor: Colors.transparent),
                child: const DefaultText.bold(text: "Login", fontSize: 14),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {},
              child: Text(
                "Continue as guest",
                style: GoogleFonts.roboto(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.sp)),
          ],
        ),
      ),
    );
  }
}
