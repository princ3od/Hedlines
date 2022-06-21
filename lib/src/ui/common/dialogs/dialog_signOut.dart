import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hedlines/src/configs/theme/app_colors.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';
import 'package:hedlines/src/routes/app_pages.dart';
import 'package:hedlines/src/ui/common/buttons/inline_button.dart';
import 'package:hedlines/src/ui/common/buttons/touchable_opacity.dart';
import 'package:hedlines/src/ui/styles/app_styles.dart';

class DialogSignOut extends StatelessWidget {
  final String? title;
  final String? cancelText;
  final String? confirmText;
  final String? bodyText;
  final Color bodyColor;
  final Function onConfirmed;
  final bool hasTextShadow;

  const DialogSignOut({
    Key? key,
    this.title,
    this.cancelText,
    this.confirmText,
    this.bodyText,
    required this.bodyColor,
    required this.onConfirmed,
    required this.hasTextShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20.sp,
        right: 22.sp,
        bottom: 8.sp,
        left: 22.sp,
      ),
      decoration: BoxDecoration(
        color: colorDialogBackGround,
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          title != null
              ? Text(
                  "Cảnh báo",
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: backgroundPrimaryColor,
                    fontWeight: FontWeight.w700,
                    height: 1.36,
                  ),
                )
              : SizedBox(),
          title != null ? SizedBox(height: 8.sp) : SizedBox(),
          SizedBox(height: 8.sp),
          bodyText != null
              ? Text(
                  bodyText!,
                  style: text14w500Blue,
                  textAlign: TextAlign.center,
                )
              : SizedBox(),
          SizedBox(height: 8.sp),
          SizedBox(
            width: 180.sp,
            height: 36.sp,
            child: InlineButton(
              onTap: () {
                onConfirmed.call();
                AppNavigator.pop();
              },
              onLongPress: null,
              leading: null,
              title: "Có",
              mainAxisSize: MainAxisSize.max,
              backgroundColor: backgroundPrimaryColor,
              textStyle: text14w700Blue.copyWith(color: colorWhite),
            ),
          ),
          SizedBox(height: 8.sp),
          SizedBox(
            width: 180.sp,
            height: 36.sp,
            child: InlineButton(
              onTap: () {
                AppNavigator.pop();
              },
              onLongPress: null,
              leading: null,
              title: "Không",
              mainAxisSize: MainAxisSize.max,
              textStyle: text14w700Blue,
            ),
          ),
          SizedBox(height: 8.sp),
        ],
      ),
    );
  }
}
