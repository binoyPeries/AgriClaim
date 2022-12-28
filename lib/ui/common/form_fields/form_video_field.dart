import 'dart:io';

import 'package:agriclaim/models/claim_media.dart';
import 'package:agriclaim/ui/common/components/primary_button.dart';
import 'package:agriclaim/ui/constants/colors.dart';
import 'package:agriclaim/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

class FormVideoField extends StatefulWidget {
  final String fieldName;
  final int maxDurationInSec;
  final Function(ClaimMedia) setVideoOnParent;

  const FormVideoField(
      {Key? key,
      required this.fieldName,
      required this.maxDurationInSec,
      required this.setVideoOnParent})
      : super(key: key);

  @override
  State<FormVideoField> createState() => _FormVideoFieldState();
}

class _FormVideoFieldState extends State<FormVideoField> {
  final ImagePicker imagePicker = ImagePicker();
  late VideoPlayerController _controller;

  File? capturedVideo;
  bool videoCaptured = false;
  bool isLoading = false;

  void selectVideo() async {
    setState(() {
      isLoading = true;
    });
    final video = await imagePicker.pickVideo(
        source: ImageSource.camera,
        maxDuration: Duration(seconds: widget.maxDurationInSec));
    if (video != null) {
      capturedVideo = File(video.path);
      videoCaptured = true;
      final location = await getCurrentLocation();
      final time = DateTime.now();
      //:TODO add the boundary checking logic here
      ClaimMedia media = ClaimMedia(
          mediaFile: video,
          latitude: location[0],
          longitude: location[1],
          capturedDateTime: time,
          accepted: true,
          mediaUrl: "");
      widget.setVideoOnParent(media);
      _controller = VideoPlayerController.file(capturedVideo!)
        ..initialize().then((_) {
          setState(() {
            isLoading = false;
          });
          _controller.setLooping(true);
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (capturedVideo != null)
          _controller.value.isInitialized
              ? Stack(
                  children: [
                    GestureDetector(
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                    Positioned(
                      bottom: 2.h,
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                          });
                        },
                        child: Icon(
                            _controller.value.isPlaying
                                ? FontAwesomeIcons.circlePause
                                : FontAwesomeIcons.circlePlay,
                            color: Colors.white,
                            size: 5.h),
                      ),
                    ),
                  ],
                )
              : SizedBox(height: 10.h),
        isLoading
            ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : SizedBox(height: 10.h),
        PrimaryButton(
            onPressed: () {
              selectVideo();
            },
            buttonColor: Colors.white,
            textColor: AgriClaimColors.tertiaryColor,
            borderColor: AgriClaimColors.tertiaryColor,
            text: videoCaptured ? "Retake video" : "Record video")
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
