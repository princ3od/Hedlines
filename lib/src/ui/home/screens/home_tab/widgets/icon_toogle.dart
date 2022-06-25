import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';
import 'package:hedlines/src/ui/common/buttons/touchable_opacity.dart';

class IconToggleButton extends StatefulWidget {
  final Function? onTap;
  final Function? onLongPress;
  final Color? inActiveColor;
  final Color? activeColor;
  final String pathImage;
  const IconToggleButton({
    this.onTap,
    this.onLongPress,
    this.inActiveColor,
    this.activeColor,
    required this.pathImage,
    Key? key,
  }) : super(key: key);

  @override
  State<IconToggleButton> createState() => _IconToggleButtonState();
}

class _IconToggleButtonState extends State<IconToggleButton> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onTap!.call();
      },
      onLongPress: () {
        widget.onLongPress!.call();
      },
      child: SvgPicture.asset(
        widget.pathImage,
        width: 24.sp,
        height: 22.sp,
        color: isSelected ? widget.activeColor : widget.inActiveColor,
      ),
    );
  }
}
