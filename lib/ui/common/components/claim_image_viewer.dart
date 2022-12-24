import 'package:agriclaim/ui/constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ClaimImagesViewer extends StatelessWidget {
  final List<String> images;
  const ClaimImagesViewer({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: images.isNotEmpty ? 35.h : 10,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GridView.builder(
            physics: const ScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, mainAxisSpacing: 2.w),
            itemBuilder: (BuildContext context, int index) {
              return CachedNetworkImage(
                imageUrl: images[index],
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border:
                          Border.all(color: AgriClaimColors.secondaryColor)),
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
              );
            }),
      ),
    );
  }
}
