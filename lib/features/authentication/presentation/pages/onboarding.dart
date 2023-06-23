import 'package:movies_app/utils/default_text.dart';

import '../../../../utils/pages.dart' as pages;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/features/authentication/presentation/widgets/custom_outline.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:movies_app/features/authentication/presentation/widgets/onboarding_item.dart';
import '../../../../utils/colors.dart' as colors;
import '../../../../utils/onboarding_list.dart' as onboarding;
import 'package:sizer/sizer.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  bool lastPage = false;
  String btnText = "Next";
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => Scaffold(
        backgroundColor: colors.primaryDark,
        body: Column(
          children: [
            SizedBox(
              width: 100.w,
              height: 90.h,
              child: PageView.builder(
                itemCount: onboarding.OnBoardingList.length,
                itemBuilder: (context, index) =>
                    OnBoardingItem(item: onboarding.OnBoardingList[index]),
                physics: const BouncingScrollPhysics(),
                controller: controller,
                onPageChanged: (value) {
                  if (value == 2) {
                    setState(() {
                      lastPage = true;
                      btnText = "Finish";
                    });
                  } else {
                    setState(() {
                      lastPage = false;
                      btnText = "Next";
                    });
                  }
                },
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 30.sp, right: 30.sp, bottom: 18.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: controller,
                    count: onboarding.OnBoardingList.length,
                    effect: ExpandingDotsEffect(
                        dotHeight: 5.sp,
                        dotWidth: 5.sp,
                        expansionFactor: 5,
                        activeDotColor: Colors.white,
                        dotColor: Colors.grey),
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 40.sp,
                              height: 40.sp,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 40.sp,
                                      color: colors.primaryBlue,
                                    )
                                  ]),
                            ),
                            Padding(padding: EdgeInsets.all(12.sp)),
                            Container(
                              width: 40.sp,
                              height: 40.sp,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 40.sp,
                                      color: colors.primaryPurple,
                                    )
                                  ]),
                            )
                          ],
                        ),
                      ),
                      UnicornOutlineButton(
                        gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [colors.primaryBlue, colors.primaryPurple]),
                        radius: 8.sp,
                        onPressed: () {},
                        strokeWidth: 2.sp,
                        child: ElevatedButton(
                            onPressed: (() {
                              if (lastPage) {
                                Navigator.pushReplacementNamed(
                                    context, pages.welcomePage);
                              } else {
                                controller.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut);
                              }
                            }),
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(120.sp, 20.sp),
                              shadowColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                            ),
                            child:
                                DefaultText.bold(text: btnText, fontSize: 14)),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
