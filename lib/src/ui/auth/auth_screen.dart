import 'package:flutter_svg/flutter_svg.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';
import 'package:flutter/material.dart';
import 'package:hedlines/src/helper/utils/assets_helper.dart';
import 'package:hedlines/src/ui/common/app_bars/app_bar_brighness_dark.dart';
import 'package:hedlines/src/ui/common/buttons/inline_button.dart';
import 'package:hedlines/src/ui/styles/app_styles.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: appBarBrighnessDark(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 77.sp,
              width: double.infinity,
            ),
            SvgPicture.asset(
              AssetsHelper.logo,
              height: 75.sp,
              width: 75.sp,
            ),
            SizedBox(
              height: 10.sp,
            ),
            Text(
              "HEDLINE",
              style: tex56w400Blue.copyWith(
                letterSpacing: -6.sp,
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            Text(
              "articles you want",
              style: tex20w400Blue,
            ),
            SizedBox(
              height: 176.sp,
            ),
            InlineButton(
                onTap: null,
                onLongPress: null,
                leading: SvgPicture.asset(
                  AssetsHelper.logo,
                  height: 25.sp,
                  width: 25.sp,
                ),
                title: "Tiếp tục với Google")
          ],
        ),
      ),
    );
  }
}
