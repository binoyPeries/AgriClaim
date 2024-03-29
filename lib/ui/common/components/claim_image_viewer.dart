import 'package:agriclaim/models/claim_media.dart';
import 'package:agriclaim/routes.dart';
import 'package:agriclaim/ui/constants/colors.dart';
import 'package:agriclaim/utils/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class ClaimImagesViewer extends StatefulWidget {
  final List<ClaimMedia> images;

  const ClaimImagesViewer({Key? key, required this.images}) : super(key: key);

  @override
  State<ClaimImagesViewer> createState() => _ClaimImagesViewerState();
}

class _ClaimImagesViewerState extends State<ClaimImagesViewer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.images.isNotEmpty ? 90.w : 4.h,
      child: GridView.builder(
          physics: const ScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: widget.images.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, mainAxisSpacing: 2.w),
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                GestureDetector(
                  onTap: () => context.push(
                      AgriClaimRoutes.viewSingleClaimImage,
                      extra: widget.images[index].mediaUrl),
                  child: CachedNetworkImage(
                    imageUrl: widget.images[index].mediaUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.contain,
                        ),
                        color: AgriClaimColors.hintColor.withOpacity(0.2),
                      ),
                    ),
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress)),
                    errorWidget: (context, url, error) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error,
                            size: 5.h,
                            color: AgriClaimColors.warningRedColor,
                          ),
                          Text(
                            "Failed to load media content",
                            style: TextStyle(fontSize: 2.h),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    getDateTimeIn12HrFormat(
                        widget.images[index].capturedDateTime),
                    style: TextStyle(
                      color: AgriClaimColors.primaryColor,
                      fontSize: 2.h,
                      backgroundColor: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 1.h, top: 1.h),
                      child: widget.images[index].accepted
                          ? Icon(
                              FontAwesomeIcons.circleCheck,
                              color: AgriClaimColors.secondaryColor,
                              size: 6.h,
                            )
                          : Icon(
                              FontAwesomeIcons.circleXmark,
                              color: Colors.red,
                              size: 6.h,
                            ),
                    )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: DotsIndicator(
                    dotsCount: widget.images.length,
                    position: index.toDouble(),
                    decorator: DotsDecorator(
                      activeColor: AgriClaimColors.primaryColor,
                      color: AgriClaimColors.hintColor,
                      size: Size(1.h, 1.h),
                      activeSize: Size(1.3.h, 1.3.h),
                      spacing: EdgeInsets.symmetric(
                          horizontal: 0.5.w, vertical: 1.h),
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}
