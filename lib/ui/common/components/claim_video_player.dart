import 'package:agriclaim/models/claim_media.dart';
import 'package:agriclaim/ui/constants/colors.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

class ClaimVideoPlayer extends StatefulWidget {
  final ClaimMedia video;
  const ClaimVideoPlayer({Key? key, required this.video}) : super(key: key);

  @override
  State<ClaimVideoPlayer> createState() => _ClaimVideoPlayerState();
}

class _ClaimVideoPlayerState extends State<ClaimVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  int? bufferDelay;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController =
        VideoPlayerController.network(widget.video.mediaUrl);

    await _videoPlayerController.initialize();
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: false,
        progressIndicatorDelay:
            bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,
        autoInitialize: true,
        showControls: true,
        allowMuting: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.red,
          handleColor: Colors.red,
          backgroundColor: Colors.white,
          bufferedColor: AgriClaimColors.hintColor,
        ),
        overlay: Container(
          color: Colors.black12.withOpacity(0.1),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return _chewieController != null &&
            _chewieController!.videoPlayerController.value.isInitialized
        ? SizedBox(
            height: 29.5.h,
            child: Chewie(
              controller: _chewieController!,
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}
