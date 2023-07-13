// import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/colors.dart' as colors;
// import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({super.key});

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late YoutubePlayerController controller;
  double height = 200.sp;
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    controller = YoutubePlayerController(
        initialVideoId: 'KcMQO7ckh3s',
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          isLive: false,
          useHybridComposition: false,
          mute: false,
          hideControls: false,
          hideThumbnail: true,
          forceHD: true,
          disableDragSeek: false,
        ));
    controller.addListener(() {
      if (MediaQuery.of(context).orientation == Orientation.landscape) {}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller,
        actionsPadding: EdgeInsets.fromLTRB(12.sp, 12.sp, 12.sp, 0.sp),
        showVideoProgressIndicator: true,
        aspectRatio: 16 / 8,
        progressIndicatorColor: colors.primaryBlue,
        bottomActions: [
          Container(
            height: 25.sp,
            width: 90.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.sp),
              color: Colors.black.withOpacity(0.5),
            ),
            child: Row(
              children: [],
            ),
          ),
        ],
      ),
      builder: (p0, p1) => GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          height: 100.h,
          width: 100.w,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Colors.transparent,
                colors.primaryDark,
                colors.primaryDark,
                Colors.transparent
              ])),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.sp),
              child: p1,
            ),
          ),
        ),
      ),
    );
  }
}
