import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hedlines/src/constants/slide_mode.dart';
import 'package:hedlines/src/ui/common/dialogs/dialog_sign_out.dart';
import 'package:hedlines/src/ui/common/dialogs/dialog_wrapper.dart';
import '../configs/theme/app_colors.dart';
import 'app_pages.dart';

class ScaffoldWrapper extends StatefulWidget {
  final Widget child;

  const ScaffoldWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

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
            child: DialogSignOut(
              onConfirmed: () async {
                AppNavigator.pop();
                exit(0);
              },
              title: "Cảnh báo",
              bodyText: "Bạn có chắc chắn\n muốn thoát app?",
              bodyColor: backgroundPrimaryColor,
              hasTextShadow: true,
            ),
          );

          return false;
        }
        return true;
      },
      child: _child,
    );
  }

  Widget get _child {
    return _getBody;
  }

  Widget get _getBody {
    return GestureDetector(
      onTap: () => _hideKeyboard(),
      child: widget.child,
    );
  }
}
