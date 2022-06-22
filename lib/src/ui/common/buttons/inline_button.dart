import 'package:flutter/material.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';
import 'package:hedlines/src/ui/common/buttons/touchable_opacity.dart';
import 'package:hedlines/src/ui/styles/app_styles.dart';

// ignore: must_be_immutable
class InlineButton extends StatefulWidget {
  Function? onTap;
  Function? onLongPress;
  Widget? leading;
  String title;
  final Color? backgroundColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final Color? borderColor;
  final double? radius;
  final double? horizontal;
  final double? height;
  final MainAxisSize mainAxisSize;
  InlineButton({
    Key? key,
    required this.onTap,
    required this.onLongPress,
    required this.leading,
    required this.title,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.textStyle,
    this.radius,
    this.horizontal,
    this.height,
    required this.mainAxisSize,
  }) : super(key: key);

  @override
  State<InlineButton> createState() => _InlineButtonState();
}

class _InlineButtonState extends State<InlineButton> {
  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: widget.horizontal ?? 8.sp),
        height: widget.height ?? 45.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius ?? 5.sp),
          color: widget.backgroundColor ?? Colors.transparent,
          border: Border.all(color: widget.borderColor ?? Colors.blueAccent),
        ),
        child: Row(
          mainAxisSize: widget.mainAxisSize,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.leading != null) widget.leading!,
            if (widget.mainAxisSize == MainAxisSize.min) const Spacer(),
            Text(
              widget.title,
              style: widget.textStyle ??
                  text14w500Blue.copyWith(
                    color: widget.textColor ?? const Color(0xff0953AD),
                  ),
              overflow: TextOverflow.ellipsis,
            ),
            if (widget.mainAxisSize == MainAxisSize.min) const Spacer(),
          ],
        ),
      ),
    );
  }
}
