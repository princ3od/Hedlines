import 'package:flutter/material.dart';
import 'package:hedlines/src/configs/theme/app_colors.dart';
import 'package:hedlines/src/ui/common/buttons/touchable_opacity.dart';
import '../../../../styles/app_styles.dart';

// ignore: must_be_immutable
class TopicReference extends StatefulWidget {
  MainAxisSize? mainAxisSize;
  final String title;
  Color? selectedTextColor;
  Color? unSelectedTextColor;
  bool isUserReference;
  Function? onTap;
  Function? onLongPress;

  TopicReference({
    Key? key,
    this.selectedTextColor,
    this.unSelectedTextColor,
    this.onTap,
    this.onLongPress,
    required this.mainAxisSize,
    required this.title,
    required this.isUserReference,
  }) : super(key: key);

  @override
  State<TopicReference> createState() => _TopicReferenceState();
}

class _TopicReferenceState extends State<TopicReference> {
  late bool isSelected;
  @override
  void initState() {
    super.initState();
    isSelected = widget.isUserReference;
  }

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onTap!.call();
      },
      onLongPress: widget.onLongPress,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(5),
          color: isSelected ? backgroundPrimaryColor : Colors.transparent,
        ),
        child: Row(
          mainAxisSize: widget.mainAxisSize ?? MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.mainAxisSize == MainAxisSize.max) const Spacer(),
            Text(
              widget.title,
              style: text10w400Blue.copyWith(
                color: isSelected
                    ? (widget.selectedTextColor ?? colorWhite)
                    : (widget.unSelectedTextColor ?? const Color(0xff0953AD)),
              ),
              overflow: TextOverflow.ellipsis,
            ),
            if (widget.mainAxisSize == MainAxisSize.max) const Spacer(),
          ],
        ),
      ),
    );
  }
}
