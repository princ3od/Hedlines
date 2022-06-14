import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar appBarBrighnessDark({
  Brightness brightness = Brightness.light,
  Color? backgroundColor,
}) {
  return AppBar(
    toolbarHeight: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: brightness,
      statusBarIconBrightness: brightness == Brightness.dark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: Colors.red,
    ),
    backgroundColor: backgroundColor ?? Colors.transparent,
    elevation: 0.0,
    automaticallyImplyLeading: false,
    centerTitle: true,
  );
}