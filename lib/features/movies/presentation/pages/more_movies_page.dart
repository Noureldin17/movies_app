import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/features/movies/domain/models/movie_model.dart';
import 'package:movies_app/features/movies/presentation/bloc/movies_bloc.dart';
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
  final controller = ScrollController();
  List<Movie> movieList = [];
  int page = 2;
  @override
  void initState() {
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        BlocProvider.of<MoviesBloc>(context)
            .add(GetMoreMoviesEvent(widget.moreMoviesArgs.moviesType, page));
      }
    });
    movieList.addAll(widget.moreMoviesArgs.movieList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primaryDark,
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            SizedBox(
              height: 200.sp,
            ),
            BlocConsumer<MoviesBloc, MoviesState>(
              listener: (context, state) {
                if (state is MoreMoviesSuccess) {
                  movieList.addAll(state.movieList);
                  setState(() {
                    page += 1;
                  });
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    ...movieList.map((movie) => Text(
                          movie.movieTitle,
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp),
                        ))
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
