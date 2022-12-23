import 'package:agriclaim/ui/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

class ClaimVideoPlayer extends StatefulWidget {
  final String videoUrl;
  const ClaimVideoPlayer({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<ClaimVideoPlayer> createState() => _ClaimVideoPlayerState();
}

class _ClaimVideoPlayerState extends State<ClaimVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        // _videoPlayerController.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return _videoPlayerController.value.isInitialized
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController),
                  ),
                  Positioned(
                    bottom: 0,
                    width: MediaQuery.of(context).size.width,
                    child: VideoProgressIndicator(
                      _videoPlayerController,
                      allowScrubbing: true,
                      colors: const VideoProgressColors(
                          backgroundColor: AgriClaimColors.hintColor,
                          bufferedColor: AgriClaimColors.secondaryColor,
                          playedColor: AgriClaimColors.tertiaryColor),
                    ),
                  )
                ],
              ),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Ink(
                      child: Icon(
                        FontAwesomeIcons.circlePlay,
                        size: 5.h,
                        color: AgriClaimColors.tertiaryColor,
                      ),
                    ),
                    onTap: () {
                      _videoPlayerController.play();
                    },
                  ),
                  SizedBox(width: 2.h),
                  InkWell(
                    child: Ink(
                      child: Icon(
                        FontAwesomeIcons.circlePause,
                        size: 5.h,
                        color: AgriClaimColors.tertiaryColor,
                      ),
                    ),
                    onTap: () {
                      _videoPlayerController.pause();
                    },
                  ),
                ],
              )
            ],
          )
        : const Center(child: CircularProgressIndicator());
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}
