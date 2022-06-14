import 'package:askany/src/constants/constants.dart';
import 'package:askany/src/routes/app_pages.dart';
import 'package:askany/src/routes/app_routes.dart';
import 'package:flutter/material.dart';

class AppMaterialPageRoute<T> extends MaterialPageRoute<T> {
  AppMaterialPageRoute({
    required WidgetBuilder builder,
    required RouteSettings settings,
  }) : super(builder: builder, settings: settings);

  @override
  Duration get transitionDuration => Duration(
        milliseconds: DELAY_250_MS,
      );

  @protected
  bool get hasScopedWillPopCallback {
    return [Routes.ROOT, Routes.EDIT_PHOTO, Routes.EDIT_PHOTO_MESSAGE]
        .contains(AppNavigator.currentRoute());
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    final PageTransitionsTheme theme = Theme.of(context).pageTransitionsTheme;
    return theme.buildTransitions<T>(
      this,
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}
