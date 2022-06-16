import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hedlines/src/configs/theme/app_colors.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';
import 'package:hedlines/src/ui/common/buttons/touchable_opacity.dart';
import 'package:hedlines/src/ui/styles/app_styles.dart';

class FieldConcern extends StatefulWidget {
  final String iconFiledConcern;
  final Color? iconInActiveColor;
  final Color? iconActiveColor;
  final Color? backgroundInActiveColor;
  final Color? backgroundActiveColor;
  final String lable;
  final Function? onTap;
  final Function? onLongPress;
  const FieldConcern({
    Key? key,
    required this.iconFiledConcern,
    this.onTap,
    this.onLongPress,
    required this.lable,
    this.iconInActiveColor,
    this.iconActiveColor,
    this.backgroundInActiveColor,
    this.backgroundActiveColor,
  }) : super(key: key);

  @override
  State<FieldConcern> createState() => _FieldConcernState();
}

class _FieldConcernState extends State<FieldConcern> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onTap?.call();
      },
      onLongPress: widget.onLongPress,
      child: SizedBox(
        width: 81.sp,
        height: 96.sp,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blueAccent,
                ),
                borderRadius: BorderRadius.circular(5.sp),
                color: isSelected ? widget.backgroundActiveColor ?? backgroundPrimaryColor : widget.backgroundInActiveColor ?? Colors.transparent,
              ),
              width: 67.sp,
              height: 67.sp,
              child: Center(
                child: SvgPicture.asset(
                  widget.iconFiledConcern,
                  color: isSelected ? widget.iconActiveColor ?? colorWhite : widget.iconInActiveColor ?? backgroundPrimaryColor,
                ),
              ),
            ),
            const Spacer(),
            Text(
              widget.lable,
              style: text14w500Blue,
            ),
          ],
        ),
      ),
    );
  }
}
