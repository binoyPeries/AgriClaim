import 'dart:io';

import 'package:agriclaim/models/claim_media.dart';
import 'package:agriclaim/ui/common/components/info_snack_bar.dart';
import 'package:agriclaim/ui/common/components/primary_button.dart';
import 'package:agriclaim/ui/constants/colors.dart';
import 'package:agriclaim/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class FormImageField extends StatefulWidget {
  final String fieldName;
  final int maxImages;
  final Function(List<ClaimMedia>) setImageListInParent;

  const FormImageField({
    Key? key,
    required this.fieldName,
    required this.maxImages,
    required this.setImageListInParent,
  }) : super(key: key);

  @override
  State<FormImageField> createState() => _FormImageFieldState();
}

class _FormImageFieldState extends State<FormImageField> {
  final ImagePicker imagePicker = ImagePicker();
  List<ClaimMedia> imageFileList = [];
  bool isLoading = false;

  void selectImages() async {
    setState(() {
      isLoading = true;
    });
    final XFile? selectedImages = await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    if (selectedImages != null) {
      if (imageFileList.length < widget.maxImages) {
        final location = await getCurrentLocation();
        final time = DateTime.now();
        //:TODO add the boundary checking logic here
        ClaimMedia media = ClaimMedia(
            mediaFile: selectedImages,
            latitude: location[0],
            longitude: location[1],
            capturedDateTime: time,
            accepted: true,
            mediaUrl: "");
        imageFileList.add(media);
        widget.setImageListInParent(imageFileList);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  void deleteImage(int index) {
    if (index < widget.maxImages) {
      imageFileList.removeAt(index);

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: imageFileList.isNotEmpty ? 40.h : 10.h,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: imageFileList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1, mainAxisSpacing: 3.w),
                    itemBuilder: (BuildContext context, int index) {
                      return ImageViewer(
                        imageFileList: getImageFileList(imageFileList),
                        imageIndex: index,
                        onPressed: () => deleteImage(index),
                      );
                    }),
          ),
        ),
        PrimaryButton(
            onPressed: imageFileList.length == widget.maxImages
                ? () {
                    ScaffoldMessenger.of(context).showSnackBar(infoSnackBar(
                        msg: "Can't add more than ${widget.maxImages} images"));
                  }
                : () async {
                    selectImages();
                  },
            buttonColor: Colors.white,
            textColor: AgriClaimColors.tertiaryColor,
            borderColor: AgriClaimColors.tertiaryColor,
            text: "Add Photo")
      ],
    );
  }
}

class ImageViewer extends StatelessWidget {
  final int imageIndex;
  final Function onPressed;
  final List<XFile> imageFileList;

  const ImageViewer({
    Key? key,
    required this.imageFileList,
    required this.imageIndex,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 1.5.h),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: AgriClaimColors.secondaryColor)),
          child: Image.file(
            File(imageFileList[imageIndex].path),
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          top: 2.h,
          right: 2.h,
          child: GestureDetector(
            onTap: () => onPressed(),
            child: const Icon(
              FontAwesomeIcons.circleXmark,
              color: AgriClaimColors.primaryColor,
            ),
          ),
        )
      ],
    );
  }
}
