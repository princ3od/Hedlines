import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';
import 'package:hedlines/src/helper/utils/assets_helper.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SvgPicture.asset(
          AssetsHelper.assets_images_logo_hedlines_svg,
          height: 75.sp,
          width: 75.sp,
        ),
      ),
    );
  }
}
