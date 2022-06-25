import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hedlines/src/routes/scaffold_wrapper.dart';
import 'package:hedlines/src/ui/article_detail/article_detail_screen.dart';
import 'package:hedlines/src/ui/auth/auth_screen.dart';
import 'package:hedlines/src/ui/home/home_screen.dart';
import 'package:hedlines/src/ui/topic/topic_screen.dart';
import 'package:hedlines/src/ui/welcome/welcome_screen.dart';
import '../app.dart';
import 'app_navigator_observer.dart';
import 'app_routes.dart';
import 'transition_route.dart';

class AppNavigator extends RouteObserver<PageRoute<dynamic>> {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.root:
        return _buildRoute(
          settings,
          const App(),
        );
      case Routes.authentication:
        return _buildRoute(
          settings,
          const AuthenticationScreen(),
        );
      case Routes.home:
        return _buildRoute(
          settings,
          const HomeScreen(),
        );
      case Routes.welcome:
        return _buildRoute(
          settings,
          const WelcomeScreen(),
        );
      case Routes.topic:
        return _buildRoute(
          settings,
          const TopicScreen(),
        );
      case Routes.articleDetail:
        return _buildRoute(
          settings,
          const ArticleDetailScreen(),
        );

      default:
        return _buildRoute(settings, const App());
    }
  }

  _buildRoute(
    RouteSettings routeSettings,
    Widget builder,
  ) {
    return AppMaterialPageRoute(
      builder: (context) => ScaffoldWrapper(child: builder),
      settings: routeSettings,
    );
  }

  static Future push<T>(
    String route, {
    Object? arguments,
    routeName,
  }) {
    return state.pushNamed(route, arguments: arguments);
  }

  static Future pushNamedAndRemoveUntil<T>(
    String route, {
    Object? arguments,
  }) {
    return state.pushNamedAndRemoveUntil(
      route,
      (route) => false,
      arguments: arguments,
    );
  }

  static Future replaceWith<T>(
    String route, {
    Map<String, dynamic>? arguments,
  }) {
    return state.pushReplacementNamed(route, arguments: arguments);
  }

  static void popUntil<T>(String route) {
    state.popUntil(ModalRoute.withName(route));
  }

  static void pop() {
    if (canPop) {
      state.pop();
    }
  }

  static bool get canPop => state.canPop();

  static String? currentRoute() => AppNavigatorObserver.currentRouteName;

  static BuildContext? get context => navigatorKey.currentContext;

  static NavigatorState get state => navigatorKey.currentState!;
}
