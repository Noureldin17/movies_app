import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/api/tmdb_api_constants.dart';
import 'package:movies_app/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:movies_app/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:movies_app/utils/default_text.dart';
import 'package:sizer/sizer.dart';
import 'utils/colors.dart' as colors;
import 'utils/pages.dart' as pages;

class AppMainPage extends StatefulWidget {
  const AppMainPage({super.key});

  @override
  State<AppMainPage> createState() => _AppMainPageState();
}

class _AppMainPageState extends State<AppMainPage> {
  @override
  void initState() {
    // BlocProvider.of<MoviesBloc>(context).add(GetMoviesEvent("Discover"));
    super.initState();
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primaryDark,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        backgroundColor: colors.primaryDark,
        currentIndex: currentIndex,
        onTap: (value) {},
        items: [
          BottomNavigationBarItem(
              label: 'Home',
              icon: SvgPicture.asset(
                'assets/navbar_icons/home.svg',
                color: Colors.white,
              ),
              activeIcon: SvgPicture.asset('assets/navbar_icons/homeactive.svg',
                  color: Colors.white)),
          BottomNavigationBarItem(
              label: 'Home',
              icon: SvgPicture.asset('assets/navbar_icons/home.svg',
                  color: Colors.white),
              activeIcon: SvgPicture.asset('assets/navbar_icons/homeactive.svg',
                  color: Colors.white)),
          BottomNavigationBarItem(
              label: 'Home',
              icon: SvgPicture.asset('assets/navbar_icons/home.svg',
                  color: Colors.white),
              activeIcon: SvgPicture.asset('assets/navbar_icons/homeactive.svg',
                  color: Colors.white)),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            BlocBuilder<MoviesBloc, MoviesState>(
              builder: (context, state) {
                if (state is MoviesSuccess) {
                  return CarouselSlider(
                      items: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.sp),
                                border: Border.all(color: colors.primaryBlue)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.sp),
                              child: Image.network(
                                "${TMDBApiConstants.IMAGE_BASE_URL}8YFL5QQVPy3AgrEQxNYVSgiPEbe.jpg",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        ...state.movieList.map((movie) => Image.network(
                            "${TMDBApiConstants.IMAGE_BASE_URL}${movie.backdropPath}")),
                        Image.network(
                            "${TMDBApiConstants.IMAGE_BASE_URL}iJQIbOPm81fPEGKt5BPuZmfnA54.jpg"),
                        Image.network(
                            "${TMDBApiConstants.IMAGE_BASE_URL}nDxJJyA5giRhXx96q1sWbOUjMBI.jpg"),
                        Image.network(
                            "${TMDBApiConstants.IMAGE_BASE_URL}ovM06PdF3M8wvKb06i4sjW3xoww.jpg"),
                      ],
                      options: CarouselOptions(
                          animateToClosest: true,
                          aspectRatio: 16 / 9,
                          scrollPhysics: const BouncingScrollPhysics(),
                          autoPlay: true,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 1000)));
                } else {
                  return Container();
                }
              },
            ),
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
