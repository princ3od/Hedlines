import 'dart:io';
import 'package:askany/src/bloc/timer/timer_bloc.dart';
import 'package:askany/src/bloc/video_call/video_call_bloc.dart';
import 'package:askany/src/configs/lang/localization.dart';
import 'package:askany/src/models/slide_mode.dart';
import 'package:askany/src/routes/app_navigator_observer.dart';
import 'package:askany/src/routes/app_pages.dart';
import 'package:askany/src/routes/app_routes.dart';
import 'package:askany/src/ui/common/widgets/appbars/appbar_none.dart';
import 'package:askany/src/ui/common/widgets/call/calling_bar.dart';
import 'package:askany/src/ui/common/widgets/dialogs/dialog_confirm_cancel.dart';
import 'package:askany/src/ui/common/widgets/dialogs/dialog_wrapper.dart';
import 'package:askany/src/ui/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:askany/src/helpers/sizer_custom/sizer.dart';

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
              bodyBefore: '${Strings.sureLogout.i18n}',
              bodyColor: colorGray1,
              cancelText: '${Strings.cancel.i18n.toUpperCase()}',
              confirmText: '${Strings.ok.i18n.toUpperCase()}',
              onConfirmed: () {
                AppNavigator.pop();
                exit(0);
              },
            ),
          );

          return false;
        }
        String descriptionDialog() {
          return Strings.descriptionCancelBookingExpert.i18n;
        }

        if (AppNavigatorObserver.currentRouteName == Routes.ORDER_EXPERT) {
          if (AppNavigator.canPop) {
            await dialogAnimationWrapper(
              borderRadius: 10.sp,
              slideFrom: SlideMode.bot,
              child: DialogConfirmCancel(
                bodyBefore: descriptionDialog(),
                confirmText: '${Strings.confirm.i18n.toUpperCase()}',
                cancelText: '${Strings.cancel.i18n.toUpperCase()}',
                onConfirmed: () async {
                  AppNavigator.pop();
                  AppNavigator.pop();
                },
              ),
            );

            return false;
          }
        }

        if (AppNavigatorObserver.currentRouteName == Routes.CREATE_REQUEST ||
            AppNavigatorObserver.currentRouteName == Routes.ADD_SKILL ||
            AppNavigatorObserver.currentRouteName == Routes.ADD_EXPERIENCE ||
            AppNavigatorObserver.currentRouteName == Routes.INFO_EXPERT ||
            AppNavigatorObserver.currentRouteName == Routes.EXPERT_EDIT_PRICE) {
          if (AppNavigator.canPop) {
            await dialogAnimationWrapper(
              child: DialogConfirmCancel(
                bodyBefore: '${Strings.areYouSureToExitScreen.i18n}',
                bodyColor: colorGray1,
                cancelText: '${Strings.cancel.i18n.toUpperCase()}',
                confirmText: '${Strings.ok.i18n.toUpperCase()}',
                onConfirmed: () {
                  AppNavigator.pop();
                  AppNavigator.pop();
                },
              ),
            );

            return false;
          }
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
            body: _getBody,
          )
        : BlocBuilder<VideoCallBloc, VideoCallState>(
            builder: (context, videoCall) {
              return BlocBuilder<TimerBloc, TimerState>(
                builder: (context, state) {
                  return videoCall is VideoCalling && AppNavigator.currentRoute() != Routes.VIDEO_CALL
                      ? Scaffold(
                          appBar: appBarBrighnessDark(brightness: Brightness.light),
                          body: Column(
                            children: [
                              Visibility(
                                  visible: AppNavigator.currentRoute() != Routes.ROOT && AppNavigator.currentRoute() != Routes.VIDEO_CALL,
                                  child: CallingBar(
                                    state: state,
                                  )),
                              Expanded(
                                child: _getBody,
                              ),
                            ],
                          ),
                        )
                      : _getBody;
                },
              );
            },
          );
  }

  Widget get _getBody {
    return GestureDetector(
      onTap: () => _hideKeyboard(),
      child: widget.child,
    );
  }
}
