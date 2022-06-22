import 'package:flutter/material.dart';

class TextUI extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final EdgeInsets? margin;
  final TextAlign? textAlign;
  final double? height;

  const TextUI(
    this.text, {
    Key? key,
    this.fontSize = 18,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    this.margin,
    this.textAlign,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (margin == null)
        ? Text(text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: color,
              height: height,
            ),
            textAlign: textAlign)
        : Container(
            margin: margin,
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: color,
                height: height,
              ),
              textAlign: textAlign,
            ),
          );
  }
}
