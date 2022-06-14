import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hedlines/src/configs/theme/app_colors.dart';
import 'package:hedlines/src/constants/constants.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';
import 'package:hedlines/src/helper/utils/assets_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Color backgroundColor = backgroundPrimaryColor;
  Color logoBackgroundColor = mCL;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: backgroundColor,
      duration: ANIMATION_DURATION_1000_MS,
      child: Center(
        child: SvgPicture.asset(
          AssetsHelper.assets_images_logo_hedlines_svg,
          color: logoBackgroundColor,
          height: 75.sp,
          width: 75.sp,
        ),
      ),
    );
  }

  @override
  void initState() {
    Future.delayed(ANIMATION_DURATION_500_MS, () {
      setState(() {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarColor: mCL,
        ));
        var temp = backgroundPrimaryColor;
        backgroundColor = mCL;
        logoBackgroundColor = temp;
      });
    });
    super.initState();
  }
}
