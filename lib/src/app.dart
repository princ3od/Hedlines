import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'helper/sizer_custom/sizer.dart';
import 'helper/utils/device_orientation_helper.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    DeviceOrientationHelper().setPortrait();
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
          localizationsDelegates: [
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
          home: BlocBuilder<ApplicationBloc, ApplicationState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, application) {
              if (application is ApplicationCompleted) {
                return ScaffoldWrapper(
                  child: Home(),
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
