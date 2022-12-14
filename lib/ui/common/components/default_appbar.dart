import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const Size defaultSize = Size.fromHeight(55);

  final String title;
  final bool backButtonVisible;

  const DefaultAppBar({
    Key? key,
    required this.title,
    this.backButtonVisible = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontSize: 20.0),
      ),
      centerTitle: true,
      leading: backButtonVisible
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white),
              iconSize: 22,
              onPressed: () => Navigator.pop(context),
            )
          : const SizedBox(),
    );
  }

  @override
  Size get preferredSize => defaultSize;
}
