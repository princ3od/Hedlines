import 'package:flutter/material.dart';
import 'package:hedlines/src/configs/theme/app_colors.dart';
import 'package:hedlines/src/controller/app_controller.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';
import 'package:hedlines/src/ui/common/app_bars/app_bar_brighness_dark.dart';
import 'package:hedlines/src/ui/common/buttons/inline_button.dart';
import 'package:hedlines/src/ui/styles/app_styles.dart';
import 'package:flutter_html/flutter_html.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    Widget html = Html(
      data: """
<div>
    <span style=" color:blue;font-size:110%">Hãy xem những bài báo gợi ý cho bạn <br>tại</span>
     <img src='asset:assets/images/svg/home_ico _light.svg' width='30'/>
    <span style="color:blue;font-size:110%">Trang chủ.</span>
</div>
""",
    );
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: appBarBrighnessDark(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          child: Column(
            children: [
              SizedBox(
                height: 40.sp,
                width: 261.sp,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Chào mừng ${AppController.userInfo.value?.fullname ?? "bạn"}\nđến với Hedlines',
                  style: text24w700Blue,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 14.sp,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: html,
              ),
              SizedBox(
                height: 57.sp,
              ),
              const Spacer(
                flex: 3,
              ),
              SizedBox(
                height: 62.sp,
              ),
              InlineButton(
                mainAxisSize: MainAxisSize.max,
                onTap: null,
                onLongPress: null,
                leading: null,
                title: "TIẾP TỤC",
                backgroundColor: backgroundPrimaryColor,
                textColor: colorWhite,
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
