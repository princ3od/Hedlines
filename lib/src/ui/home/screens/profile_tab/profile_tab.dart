import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedlines/src/configs/theme/app_colors.dart';
import 'package:hedlines/src/constants/app_state.dart';
import 'package:hedlines/src/controller/home/profile_tab/profile_controller.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';
import 'package:hedlines/src/helper/utils/assets_helper.dart';
import 'package:hedlines/src/routes/app_routes.dart';
import 'package:hedlines/src/ui/common/buttons/inline_button.dart';
import 'package:hedlines/src/ui/home/screens/profile_tab/widgets/topic_reference.dart';
import 'package:hedlines/src/ui/styles/app_styles.dart';

import '../../../../configs/lang/localization.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/slide_mode.dart';
import '../../../../controller/app_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../common/dialogs/dialog_confirm_cancel.dart';
import '../../../common/dialogs/dialog_signOut.dart';
import '../../../common/dialogs/dialog_wrapper.dart';
import 'widgets/profile_overlay.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> with SingleTickerProviderStateMixin {
  ProfileController profileController = Get.put(ProfileController());

  final List<String> gridData = ["Kinh doanh", "Giải trí", "Thời sự", "Du lịch", "Thể thao", "Công nghệ"];
  late List<String> topicChoose;
  bool isShowSaveButton = true;
  late Animation<double> animation;
  late AnimationController controller;

  late final OverlayEntry _overlayEntry;
  @override
  void initState() {
    super.initState();
    topicChoose = [...profileController.userModel.value.preferences];
    controller = AnimationController(duration: ANIMATION_DURATION_1000_MS, vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.linearToEaseOut)..addListener(() {});
    _overlayEntry = OverlayEntry(
      builder: (context) {
        final size = MediaQuery.of(context).size;
        return SlideTransition(
          position: Tween(begin: Offset(0, -1), end: Offset(0, 0)).animate(animation),
          child: Container(
            width: size.width,
            height: size.height,
            color: Colors.black.withOpacity(0.45),
            child: ProfileOverlay(
              onTap: () {
                controller.reverse().then((value) {
                  _overlayEntry.remove();
                });
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return SafeArea(
      child: Stack(children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 61.sp,
              ),
              Text(
                "Hồ sơ",
                style: text24w700Blue,
              ),
              SizedBox(
                height: 10.sp,
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(AppController.userInfo.value?.avatar ?? ""),
                    foregroundImage: const AssetImage(AssetsHelper.iconHome),
                    radius: 20.sp,
                  ),
                  SizedBox(
                    width: 16.sp,
                  ),
                  Text(
                    profileController.userModel.value.fullname ?? "",
                    style: text14w500Blue,
                  ),
                ],
              ),
              SizedBox(
                height: 27.sp,
              ),
              Text(
                "Chủ đề của tôi",
                style: text16w600Blue,
              ),
              SizedBox(
                height: 250.sp,
              ),
              InlineButton(
                onTap: () {
                  dialogAnimationWrapper(
                    slideFrom: SlideMode.bot,
                    child: DialogSignOut(
                      onConfirmed: () {
                        profileController.signOut();
                      },
                      title: "Cảnh báo",
                      bodyText: "Bạn có chắc chắn\nđăng xuất?",
                      bodyColor: backgroundPrimaryColor,
                      hasTextShadow: true,
                    ),
                  );
                },
                onLongPress: null,
                leading: null,
                title: "Đăng xuất",
                mainAxisSize: MainAxisSize.max,
                textStyle: text14w700Blue,
              ),
            ],
          ),
        ),
        Positioned(
          top: 280.sp,
          left: 8.sp,
          child: Opacity(
            opacity: isShowSaveButton ? 1 : 0,
            child: SizedBox(
              width: 150.sp,
              height: 35.sp,
              child: InlineButton(
                leading: null,
                mainAxisSize: MainAxisSize.max,
                onLongPress: null,
                onTap: null,
                title: "Lưu",
                textStyle: text14w700Blue,
              ),
            ),
          ),
        ),
        Positioned(
          top: 186.sp,
          left: 8.sp,
          child: SizedBox(
            width: 213.sp,
            height: 100.sp,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: gridData.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (orientation == Orientation.portrait) ? 3 : 5,
                mainAxisSpacing: (orientation == Orientation.portrait) ? 4.sp : 8.sp,
                crossAxisSpacing: (orientation == Orientation.portrait) ? 2.sp : 5.sp,
                childAspectRatio: 4 / 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return TopicReference(
                  isUserReference: topicChoose.contains(gridData[index]),
                  mainAxisSize: MainAxisSize.max,
                  title: gridData[index],
                );
              },
            ),
          ),
        )
      ]),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // _toggleTopic(String topic) {
  //   if (profileController.userModel.value.topicPreferences.contains(topic)) {
  //     profileController.userModel.value.topicPreferences.remove(topic);
  //   } else {
  //     profileController.userModel.value.topicPreferences.add(topic);
  //   }
  // }
}
