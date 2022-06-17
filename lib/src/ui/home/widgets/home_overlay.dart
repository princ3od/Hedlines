import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';
import 'package:hedlines/src/helper/utils/assets_helper.dart';
import 'package:hedlines/src/ui/common/buttons/inline_button.dart';
import 'package:hedlines/src/ui/common/gesture_detector/custom_gesture_detector.dart';
import 'package:hedlines/src/ui/styles/app_styles.dart';

class HomeOverlay extends StatefulWidget {
  final Function onTap;
  const HomeOverlay({Key? key, required this.onTap}) : super(key: key);

  @override
  State<HomeOverlay> createState() => _HomeOverlayState();
}

class _HomeOverlayState extends State<HomeOverlay> {
  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      onSwipeDown: widget.onTap,
      child: Material(
        color: Colors.transparent,
        child: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: 44.sp,
            ),
            Text(
              "Vuốt lên để xem bài khác",
              style: text14w500Blue.copyWith(color: colorWhite),
            ),
            SizedBox(
              height: 19.sp,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 8.sp),
                  child: InlineButton(
                    mainAxisSize: MainAxisSize.max,
                    onTap: widget.onTap,
                    onLongPress: null,
                    leading: null,
                    title: "OK",
                    borderColor: colorWhite,
                    textColor: colorWhite,
                  ),
                )),
                Expanded(
                  child: Align(
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.sp),
                      child: SvgPicture.asset(AssetsHelper.iconSwipeUp),
                    ),
                    alignment: Alignment.centerRight,
                  ),
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}
