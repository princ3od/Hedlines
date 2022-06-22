import 'package:flutter_svg/flutter_svg.dart';
import 'package:hedlines/src/constants/sign_type.dart';
import 'package:hedlines/src/controller/auth/auth_controller.dart';
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
  AuthenticationController authController = AuthenticationController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: appBarBrighnessDark(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
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
                style: text56w400Blue.copyWith(
                  letterSpacing: -6.sp,
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Text(
                "articles you want",
                style: text20w400Blue,
              ),
              SizedBox(
                height: 176.sp,
              ),
              InlineButton(
                mainAxisSize: MainAxisSize.min,
                onTap: () {
                  authController.onAuthentication(SignInType.google);
                },
                onLongPress: null,
                horizontal: 16.sp,
                leading: SvgPicture.asset(
                  AssetsHelper.icoGoogle,
                  height: 25.sp,
                  width: 25.sp,
                ),
                title: "Tiếp tục với Google",
              )
            ],
          ),
        ),
      ),
    );
  }
}
