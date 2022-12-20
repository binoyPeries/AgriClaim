import 'dart:io';

import 'package:agriclaim/ui/common/components/info_snack_bar.dart';
import 'package:agriclaim/ui/common/components/primary_button.dart';
import 'package:agriclaim/ui/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class FormImageField extends StatefulWidget {
  final String fieldName;
  final int maxImages;
  final Function(List<XFile>) setImageListInParent;

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
  List<XFile> imageFileList = [];

  void selectImages() async {
    final XFile? selectedImages =
        await imagePicker.pickImage(source: ImageSource.camera);
    if (selectedImages != null) {
      if (imageFileList.length < widget.maxImages) {
        imageFileList.add(selectedImages);
        widget.setImageListInParent(imageFileList);
      }
    }
    setState(() {});
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: imageFileList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1),
              itemBuilder: (BuildContext context, int index) {
                return ImageViewer(
                  imageFileList: imageFileList,
                  imageIndex: index,
                  onPressed: () => deleteImage(index),
                );
              }),
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
