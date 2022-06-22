import 'package:flutter/material.dart';

class BarTitle extends StatelessWidget {
  final String title;
  final TextStyle style;
  const BarTitle({
    Key? key,
    required this.title,
    required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: style,
        ),
      ],
    );
  }
}
