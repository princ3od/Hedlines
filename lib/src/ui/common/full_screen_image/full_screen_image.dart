import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class FullImageScreen extends StatelessWidget {
  final String imageURL;
  final String tag;
  const FullImageScreen({Key? key, required this.imageURL, this.tag = ""})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: (tag.isEmpty) ? imageURL : tag,
      child: PageView(
        scrollDirection: Axis.vertical,
        onPageChanged: (value) => Get.back(),
        children: [
          PhotoView(
            onTapDown: (context, details, controllerValue) => Get.back(),
            onTapUp: (context, details, controllerValue) => Get.back(),
            initialScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 1.0,
            imageProvider: NetworkImage(imageURL),
          ),
          Container(),
        ],
      ),
    );
  }
}
