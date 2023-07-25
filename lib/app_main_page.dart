import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:movies_app/core/api/tmdb_api_constants.dart';
// import 'package:movies_app/features/authentication/presentation/bloc/authentication_bloc.dart';
// import 'package:movies_app/features/movies/presentation/bloc/movies_bloc.dart';
// import 'package:sizer/sizer.dart';
// import 'package:movies_app/utils/default_text.dart';
// import 'utils/pages.dart' as pages;
import 'package:movies_app/features/movies/presentation/pages/movies_page.dart';
import 'features/movies/presentation/pages/watchlist_page.dart';
import 'utils/colors.dart' as colors;

class AppMainPage extends StatefulWidget {
  const AppMainPage({super.key});

  @override
  State<AppMainPage> createState() => _AppMainPageState();
}

class _AppMainPageState extends State<AppMainPage> {
  final body = [
    const MoviesPage(),
    const WatchListPage(),
    const WatchListPage(),
    const WatchListPage(),
  ];
  int currentIndex = 0;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors.primaryDark,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          backgroundColor: colors.primaryDark,
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
                label: 'movies',
                backgroundColor: colors.primaryDark,
                icon: SvgPicture.asset(
                  'assets/navbar_icons/video-vertical-outline.svg',
                  color: Colors.white,
                ),
                activeIcon: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [colors.primaryBlue, colors.primaryPurple])
                        .createShader(bounds),
                    child: SvgPicture.asset('assets/navbar_icons/video.svg',
                        color: Colors.white))),
            BottomNavigationBarItem(
                label: 'search',
                backgroundColor: colors.primaryDark,
                icon: SvgPicture.asset('assets/navbar_icons/search.svg',
                    color: Colors.white),
                activeIcon: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [colors.primaryBlue, colors.primaryPurple])
                        .createShader(bounds),
                    child: SvgPicture.asset(
                        'assets/navbar_icons/search-active.svg',
                        color: Colors.white))),
            BottomNavigationBarItem(
                label: 'watchlist',
                backgroundColor: colors.primaryDark,
                icon: SvgPicture.asset('assets/navbar_icons/archive-minus.svg',
                    color: Colors.white),
                activeIcon: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [colors.primaryBlue, colors.primaryPurple])
                        .createShader(bounds),
                    child: SvgPicture.asset(
                        'assets/navbar_icons/archive-minusactive.svg',
                        color: Colors.white))),
            BottomNavigationBarItem(
                label: 'profile',
                backgroundColor: colors.primaryDark,
                icon: SvgPicture.asset('assets/navbar_icons/profile.svg',
                    color: Colors.white),
                activeIcon: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [colors.primaryBlue, colors.primaryPurple])
                        .createShader(bounds),
                    child: SvgPicture.asset(
                        'assets/navbar_icons/profileactive.svg',
                        color: Colors.white))),
          ],
        ),
        body: WillPopScope(
          onWillPop: () async {
            if (currentIndex == 0) {
              return true;
            } else {
              setState(() {
                currentIndex = 0;
              });
              return false;
            }
          },
          child: LazyLoadIndexedStack(
            index: currentIndex,
            children: body,
          ),
        ));
  }
}
