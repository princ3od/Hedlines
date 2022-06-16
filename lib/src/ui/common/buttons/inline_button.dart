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
  InlineButton({Key? key, required this.onTap, required this.onLongPress, required this.leading, required this.title, this.backgroundColor, this.textColor}) : super(key: key);

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
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        height: 45.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.sp),
          color: widget.backgroundColor ?? Colors.transparent,
          border: Border.all(color: Colors.blueAccent),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget.leading ?? const SizedBox(),
            const Spacer(),
            Center(
              child: Text(
                widget.title,
                style: tex14w500Blue.copyWith(
                  color: widget.textColor ?? const Color(0xff0953AD),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
