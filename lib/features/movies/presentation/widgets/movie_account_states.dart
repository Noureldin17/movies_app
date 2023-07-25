import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/colors.dart' as colors;

class MovieAccountStates extends StatefulWidget {
  const MovieAccountStates({
    super.key,
    required this.currentRatedState,
    required this.currentWatchlistState,
    required this.movieId,
  });
  final int movieId;
  final bool currentRatedState;
  final bool currentWatchlistState;
  @override
  State<MovieAccountStates> createState() => _MovieAccountStatesState();
}

class _MovieAccountStatesState extends State<MovieAccountStates> {
  late bool ratedState;
  late bool watchlistState;
  @override
  void initState() {
    ratedState = widget.currentRatedState;
    watchlistState = widget.currentWatchlistState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: !ratedState
                      ? SvgPicture.asset('assets/icons/star-outline.svg',
                          color: colors.primaryGrey)
                      : SvgPicture.asset('assets/icons/star.svg',
                          color: Colors.yellow)),
              Text(
                'Rate',
                style: GoogleFonts.roboto(
                    color: colors.primaryGrey,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AddToWatchListSuccess) {
                setState(() {
                  watchlistState = !watchlistState;
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(GetWatchListEvent());
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    dismissDirection: DismissDirection.horizontal,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                        color: colors.primaryBlue,
                        title: watchlistState ? "Added!" : "Removed!",
                        message: watchlistState
                            ? "Movie added to your watchlist successfully!"
                            : "Movie removed from your watchlist successfully!",
                        contentType: ContentType.success)));
              } else if (state is AddToWatchListError) {
                print(state.message);
              }
            },
            child: Column(
              children: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                          AddToWatchListEvent(widget.movieId, !watchlistState));
                    },
                    icon: !watchlistState
                        ? SvgPicture.asset(
                            'assets/icons/archive.svg',
                            color: colors.primaryGrey,
                          )
                        : SvgPicture.asset(
                            'assets/icons/archive-filled.svg',
                            color: Colors.white,
                          )),
                Text(
                  'Add to List',
                  style: GoogleFonts.roboto(
                      color: colors.primaryGrey,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
