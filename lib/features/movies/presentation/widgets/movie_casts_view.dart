import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:movies_app/core/api/tmdb_api_constants.dart';
import 'package:movies_app/features/movies/domain/models/movie_credits_model.dart';

import 'package:movies_app/utils/default_text.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/colors.dart' as colors;

class MovieCastsView extends StatefulWidget {
  const MovieCastsView({super.key, required this.cast});
  final List<Member> cast;
  @override
  State<MovieCastsView> createState() => _MovieCastsViewState();
}

class _MovieCastsViewState extends State<MovieCastsView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12.sp, top: 10.sp),
          child: Row(
            children: [
              Container(
                width: 2.sp,
                height: 16.sp,
                color: colors.primaryBlue,
              ),
              Padding(padding: EdgeInsets.only(left: 6.sp)),
              const DefaultText.bold(text: 'Top Casts', fontSize: 16)
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 6.sp)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.fromLTRB(0.sp, 10.sp, 12.sp, 0.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...widget.cast.map((member) => Padding(
                    padding: EdgeInsets.only(left: 14.sp),
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              '${TMDBApiConstants.IMAGE_BASE_URL}${member.profilePath}',
                          imageBuilder: (context, imageProvider) => Container(
                            padding: EdgeInsets.all(1.sp),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  colors.primaryBlue,
                                  colors.primaryPurple
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 25.sp,
                              backgroundImage: imageProvider,
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            padding: EdgeInsets.all(1.sp),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  colors.primaryBlue,
                                  colors.primaryPurple
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 25.sp,
                              backgroundImage:
                                  const AssetImage('assets/blank-profile.png'),
                            ),
                          ),
                          // placeholder: (context, url) => const CircleAvatar(
                          //   backgroundImage:
                          //       AssetImage('assets/blank-profile.png'),
                          // ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 4.sp)),
                        SizedBox(
                          width: 50.sp,
                          height: 20.sp,
                          child: Text(
                            member.originalName,
                            maxLines: 4,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 8.sp),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 4.sp)),
                        SizedBox(
                          width: 50.sp,
                          height: 20.sp,
                          child: Text(
                            member.character,
                            maxLines: 4,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                color: colors.primaryGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: 8.sp),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        )
      ],
    );
  }
}
