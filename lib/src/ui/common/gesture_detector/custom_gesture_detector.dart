import 'package:flutter/material.dart';

class CustomGestureDetector extends StatefulWidget {
  final Function? onSwipeLeft;
  final Function? onSwipeRight;
  final Function? onSwipeUp;
  final Function? onSwipeDown;
  final Widget child;
  const CustomGestureDetector({
    Key? key,
    required this.child,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.onSwipeUp,
    this.onSwipeDown,
  }) : super(key: key);

  @override
  State<CustomGestureDetector> createState() => _CustomGestureDetectorState();
}

class _CustomGestureDetectorState extends State<CustomGestureDetector> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: widget.child,
      onHorizontalDragEnd: (dragEndDetails) {
        if (dragEndDetails.primaryVelocity! < 0) {
          widget.onSwipeRight?.call();
        } else if (dragEndDetails.primaryVelocity! > 0) {
          widget.onSwipeLeft?.call();
        }
      },
      onVerticalDragEnd: (dragEndDetails) {
        if (dragEndDetails.primaryVelocity! < 0) {
          widget.onSwipeDown?.call();
        } else if (dragEndDetails.primaryVelocity! > 0) {
          widget.onSwipeUp?.call();
        }
      },
    );
  }
}
