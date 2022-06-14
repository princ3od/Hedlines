import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hedlines/src/constants/slide_mode.dart';
import 'package:hedlines/src/ui/common/app_bars/app_bar_brighness_dark.dart';
import 'package:hedlines/src/ui/common/dialogs/dialog_confirm_cancel.dart';
import 'package:hedlines/src/ui/common/dialogs/dialog_wrapper.dart';
import 'package:hedlines/src/ui/styles/app_styles.dart';
import 'app_pages.dart';
import 'app_routes.dart';

class ScaffoldWrapper extends StatefulWidget {
  final Widget child;

  ScaffoldWrapper({
    required this.child,
  });

  @override
  _ScaffoldWrapperState createState() => _ScaffoldWrapperState();
}

class _ScaffoldWrapperState extends State<ScaffoldWrapper> {
  _hideKeyboard() {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!AppNavigator.canPop) {
          await dialogAnimationWrapper(
            slideFrom: SlideMode.bot,
            child: DialogConfirmCancel(
              bodyBefore: '{Strings.sureLogout.i18n}',
              bodyColor: colorGray1,
              cancelText: '{Strings.cancel.i18n.toUpperCase()}',
              confirmText: '{Strings.ok.i18n.toUpperCase()}',
              onConfirmed: () {
                AppNavigator.pop();
                exit(0);
              },
            ),
          );

          return false;
        }
        String descriptionDialog() {
          return "Strings.descriptionCancelBookingExpert.i18n";
        }

        return true;
      },
      child: _child,
    );
  }

  Widget get _child {
    return AppNavigator.currentRoute() == Routes.ROOT
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            extendBody: true,
            appBar: appBarBrighnessDark(brightness: Brightness.light),
            body: _getBody,
          )
        : _getBody;
  }

  Widget get _getBody {
    return GestureDetector(
      onTap: () => _hideKeyboard(),
      child: widget.child,
    );
  }
}
