import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';
import 'package:hedlines/src/helper/utils/assets_helper.dart';
import 'package:hedlines/src/ui/common/buttons/touchable_opacity.dart';
import 'package:hedlines/src/ui/styles/app_styles.dart';

class InlineButton extends StatefulWidget {
  Function? onTap;
  Function? onLongPress;
  Widget? leading;
  String? title;
  InlineButton({Key? key, @required this.onTap, @required this.onLongPress, @required this.leading, @required this.title}) : super(key: key);

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
        margin: EdgeInsets.symmetric(horizontal: 16.sp),
        padding: EdgeInsets.symmetric(horizontal: 17.sp),
        height: 60.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.sp),
          color: Colors.transparent,
          border: Border.all(color: Colors.blueAccent),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget.leading ?? const SizedBox(),
            const Spacer(),
            Center(
              child: Text(
                widget.title ?? "",
                style: tex14w500Blue,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
