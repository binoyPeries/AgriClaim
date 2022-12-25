import 'package:agriclaim/ui/constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ClaimImagesViewer extends StatefulWidget {
  final List<String> images;

  const ClaimImagesViewer({Key? key, required this.images}) : super(key: key);

  @override
  State<ClaimImagesViewer> createState() => _ClaimImagesViewerState();
}

class _ClaimImagesViewerState extends State<ClaimImagesViewer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.images.isNotEmpty ? 100.w : 10,
      child: GridView.builder(
          physics: const ScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: widget.images.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, mainAxisSpacing: 2.w),
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.images[index],
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                      color: AgriClaimColors.hintColor.withOpacity(0.2),
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress)),
                  errorWidget: (context, url, error) => Center(
                      child: Icon(
                    Icons.error,
                    size: 3.h,
                  )),
                ),
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
