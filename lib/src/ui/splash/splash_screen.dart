import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hedlines/src/configs/theme/app_colors.dart';
import 'package:hedlines/src/constants/constants.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';
import 'package:hedlines/src/helper/utils/assets_helper.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Color backgroundColor = backgroundPrimaryColor;
  Color logoBackgroundColor = mCL;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    Future.delayed(ANIMATION_DURATION_500_MS, () {
      setState(() {
        var temp = backgroundPrimaryColor;
        backgroundColor = mCL;
        logoBackgroundColor = temp;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: backgroundColor,
      duration: ANIMATION_DURATION_1000_MS,
      child: Center(
        child: SvgPicture.asset(
          AssetsHelper.logo,
          color: logoBackgroundColor,
          height: 75.sp,
          width: 75.sp,
        ),
      ),
    );
  }
}

class MyClip extends CustomClipper<Path> {
  double move = 0;
  MyClip(this.move);
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height - move);
    path.lineTo(0, size.height - move);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
