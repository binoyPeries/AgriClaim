import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ClaimPhotoFullScreenViewer extends StatelessWidget {
  final String image;
  const ClaimPhotoFullScreenViewer({Key? key, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: CachedNetworkImageProvider(image),
    );
  }
}
