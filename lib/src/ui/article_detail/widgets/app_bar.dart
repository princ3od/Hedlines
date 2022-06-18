import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hedlines/src/configs/theme/app_colors.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';
import 'package:hedlines/src/routes/app_pages.dart';
import 'package:hedlines/src/ui/common/buttons/touchable_opacity.dart';
import 'package:hedlines/src/ui/styles/app_styles.dart';

AppBar appBarTitleBack({
  String? title,
  String? assetIcon,
  List<Widget>? actions,
  Function? onBackPressed,
  Color? backgroundColor,
  Brightness? brightness,
  double? paddingLeft,
  Color? colorChild,
  PreferredSizeWidget? bottom,
  Widget? titleWidget,
  Widget? leading,
  double? elevation,
  bool? isVisibleBackButton = true,
}) {
  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: brightness ?? Theme.of(AppNavigator.context!).brightness,
      statusBarIconBrightness: (brightness ?? Theme.of(AppNavigator.context!).brightness) == Brightness.dark ? Brightness.light : Brightness.dark,
    ),
    elevation: elevation ?? 0.25,
    backgroundColor: backgroundColor ?? backgroundPrimaryColor,
    automaticallyImplyLeading: false,
    centerTitle: true,
    leadingWidth: 40.sp,
    title: titleWidget ?? Text(title ?? "", style: text13w700cWhite),
    actions: actions,
    bottom: bottom,
    leading: TouchableOpacity(
      onTap: () {
        if (onBackPressed != null) {
          onBackPressed();
        } else {
          AppNavigator.pop();
        }
      },
      child: Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: paddingLeft ?? 12.sp),
        child: Icon(
          Icons.arrow_back_ios,
          size: 23.sp,
          color: Colors.white,
        ),
      ),
    ),
  );
}
