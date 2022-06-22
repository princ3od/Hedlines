import 'package:flutter/material.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';
import 'package:hedlines/src/ui/common/buttons/touchable_opacity.dart';
import 'package:hedlines/src/ui/styles/app_styles.dart';

class DialogAnnouncement extends StatelessWidget {
  const DialogAnnouncement(
      {Key? key,
      required this.onConfirmed,
      this.bodyBefore,
      this.bodyAfter,
      this.highlightText,
      this.title,
      this.titleColor = colorBlack1,
      this.bodyColor = colorBlack1,
      this.highlightColor = colorGreen2,
      this.confirmText,
      this.hasTextShadow = false,
      this.beforeTextAlign = TextAlign.justify})
      : assert(
          bodyBefore != null || bodyAfter != null,
          'The body before and the body after can not both be null.',
        ),
        super(key: key);

  final String? title;
  final String? bodyBefore;
  final String? bodyAfter;
  final String? highlightText;
  final String? confirmText;
  final Color titleColor;
  final Color bodyColor;
  final Color highlightColor;
  final Function onConfirmed;
  final bool hasTextShadow;
  final TextAlign beforeTextAlign;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != null
              ? Text(
                  title!,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: titleColor,
                    fontWeight: FontWeight.w600,
                    height: 1.36,
                  ),
                )
              : const SizedBox(),
          title != null ? SizedBox(height: 8.sp) : const SizedBox(),
          RichText(
            textAlign: beforeTextAlign,
            text: TextSpan(
              style: TextStyle(fontSize: 13.sp, height: 1.625),
              children: [
                TextSpan(
                  text: bodyBefore,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: bodyColor,
                  ),
                ),
                highlightText != null
                    ? TextSpan(
                        text: ' $highlightText ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: highlightColor,
                        ),
                      )
                    : const TextSpan(),
                TextSpan(
                  text: bodyAfter,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: bodyColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.sp),
          SizedBox(
            height: 48.sp,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TouchableOpacity(
                  onTap: onConfirmed,
                  child: Text(
                    confirmText ?? "Confirm".toUpperCase(),
                    style: TextStyle(
                      color: colorGreen2,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      shadows: hasTextShadow
                          ? <Shadow>[
                              Shadow(
                                offset: const Offset(2.0, 3.0),
                                blurRadius: 2.0,
                                color: Colors.grey.shade300,
                              ),
                            ]
                          : [],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
