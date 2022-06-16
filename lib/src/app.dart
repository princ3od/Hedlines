import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hedlines/src/constants/app_state.dart';
import 'package:hedlines/src/routes/app_navigator_observer.dart';
import 'package:hedlines/src/routes/app_pages.dart';
import 'package:hedlines/src/routes/app_routes.dart';
import 'package:hedlines/src/routes/scaffold_wrapper.dart';
import 'package:hedlines/src/ui/auth/auth_screen.dart';
import 'package:hedlines/src/ui/home/home_screen.dart';
import 'package:hedlines/src/ui/splash/splash_screen.dart';
import 'package:hedlines/src/ui/topic/topic_screen.dart';
import 'package:hedlines/src/ui/welcome/wellcome_screen.dart';
import 'configs/lang/language_service.dart';
import 'configs/theme/theme_service.dart';
import 'configs/theme/themes.dart';
import 'controller/app_controller.dart';
import 'helper/sizer_custom/sizer.dart';
import 'helper/utils/device_orientation_helper.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final appController = Get.put(AppController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    DeviceOrientationHelper().setPortrait();
    appController.setUpData(context);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // App moved to foreground
        break;
      case AppLifecycleState.paused:
        // App moved to background

        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          navigatorKey: AppNavigator.navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Hedlines',
          locale: LanguageService.locale,
          supportedLocales: LanguageService.supportLanguage,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: AppTheme.light().data,
          darkTheme: AppTheme.dark().data,
          themeMode: ThemeService.currentTheme,
          initialRoute: Routes.ROOT,
          onGenerateRoute: (settings) {
            return AppNavigator().getRoute(settings);
          },
          navigatorObservers: [
            AppNavigatorObserver(),
          ],
          builder: (context, child) {
            return MediaQuery(
              child: child!,
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            );
          },
          home: GetBuilder<AppController>(
            builder: (appController) {
              if (AppState.loaded == appController.appState.value) {
                return ScaffoldWrapper(
                  child: WellcomeScreen(),
                );
              }
              return ScaffoldWrapper(child: SplashScreen());
            },
          ),
        );
      },
    );
  }
}
