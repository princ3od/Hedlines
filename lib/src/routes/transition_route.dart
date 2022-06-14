
import 'package:flutter/material.dart';
import 'package:hedlines/src/constants/constants.dart';
import 'package:hedlines/src/routes/app_routes.dart';

import 'app_pages.dart';

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
    return [Routes.ROOT]
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
