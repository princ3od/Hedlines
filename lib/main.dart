import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hedlines/src/app.dart';
import 'package:i18n_extension/i18n_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
  ));

  runApp(I18n(child: const App()));
}
