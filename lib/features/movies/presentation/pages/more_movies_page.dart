import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/features/movies/domain/models/movie_model.dart';
import 'package:movies_app/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:movies_app/features/movies/presentation/widgets/gradient_divider.dart';
import 'package:movies_app/features/movies/presentation/widgets/movie_list_tile.dart';
import 'package:movies_app/utils/default_text.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/colors.dart' as colors;
import '../../domain/models/more_movies_args_model.dart';

class MoreMoviesPage extends StatefulWidget {
  const MoreMoviesPage({super.key, required this.moreMoviesArgs});
  final MoreMoviesArgs moreMoviesArgs;
  @override
  State<MoreMoviesPage> createState() => _MoreMoviesPageState();
}

class _MoreMoviesPageState extends State<MoreMoviesPage> {
  late CacheManager customCacheManager;

  final controller = ScrollController();
  List<Movie> movieList = [];
  List<Widget> widgetList = [];
  int page = 2;
  bool actionBtnVisible = false;
  @override
  void initState() {
    customCacheManager = CacheManager(Config('customPosterKey',
        stalePeriod: const Duration(minutes: 10), maxNrOfCacheObjects: 100));

    movieList.addAll(widget.moreMoviesArgs.movieList);
    widgetList.addAll(widget.moreMoviesArgs.movieList.map((movie) =>
        MovieListTile(
            key: UniqueKey(),
            movie: movie,
            movieType: widget.moreMoviesArgs.moviesType,
            cacheManager: customCacheManager)));
    super.initState();
  }

  @override
  void deactivate() async {
    movieList.clear();
    await customCacheManager.emptyCache();
    controller.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primaryDark,
        shadowColor: Colors.transparent,
        title: DefaultText.bold(
            text: widget.moreMoviesArgs.moviesType, fontSize: 16),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: actionBtnVisible
          ? SizedBox(
              height: 35.sp,
              width: 35.sp,
              child: FloatingActionButton(
                tooltip: "Back to top",
                onPressed: () {
                  controller.animateTo(0,
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.decelerate);
                  setState(() {
                    actionBtnVisible = false;
                  });
                },
                child: Container(
                  height: 35.sp,
                  width: 35.sp,
                  padding: EdgeInsets.all(8.sp),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [colors.primaryBlue, colors.primaryPurple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/top.svg',
                    color: Colors.white,
                    width: 14.sp,
                    height: 14.sp,
                  ),
                ),
              ),
            )
          : null,
      backgroundColor: colors.primaryDark,
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels >=
              notification.metrics.maxScrollExtent) {
            BlocProvider.of<MoviesBloc>(context).add(
                GetMoreMoviesEvent(widget.moreMoviesArgs.moviesType, page));
          }
          if (notification.metrics.pixels > 100.h) {
            if (!actionBtnVisible) {
              setState(() {
                actionBtnVisible = true;
              });
            }
          } else if (notification.metrics.pixels < 100.h) {
            if (actionBtnVisible) {
              setState(() {
                actionBtnVisible = false;
              });
            }
          }
          return true;
        },
        child: Column(
          children: [
            BlocConsumer<MoviesBloc, MoviesState>(
              listener: (context, state) {
                if (state is MoreMoviesSuccess) {
                  setState(() {
                    movieList.addAll(state.movieList);
                    widgetList.addAll(state.movieList.map((movie) =>
                        MovieListTile(
                            key: UniqueKey(),
                            movie: movie,
                            movieType: widget.moreMoviesArgs.moviesType,
                            cacheManager: customCacheManager)));
                    page += 1;
                  });
                }
              },
              builder: (context, state) {
                return const SizedBox();
              },
            ),
            Expanded(
              child: ListView.separated(
                  addSemanticIndexes: true,
                  addRepaintBoundaries: true,
                  addAutomaticKeepAlives: true,
                  separatorBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(top: 5.sp, bottom: 5.sp),
                        child: const GradientDivider(),
                      ),
                  controller: controller,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: widgetList.length,
                  itemBuilder: (context, index) => widgetList[index]),
            )
          ],
        ),
      ),
    );
  }
}
