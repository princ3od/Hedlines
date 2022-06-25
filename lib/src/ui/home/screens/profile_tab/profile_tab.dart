import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedlines/src/configs/theme/app_colors.dart';
import 'package:hedlines/src/controller/home/profile_tab/profile_controller.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';
import 'package:hedlines/src/helper/utils/assets_helper.dart';
import 'package:hedlines/src/ui/common/buttons/inline_button.dart';
import 'package:hedlines/src/ui/home/screens/profile_tab/widgets/topic_reference.dart';
import 'package:hedlines/src/ui/styles/app_styles.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/slide_mode.dart';
import '../../../../controller/app_controller.dart';
import '../../../common/dialogs/dialog_sign_out.dart';
import '../../../common/dialogs/dialog_wrapper.dart';
import 'widgets/profile_overlay.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with SingleTickerProviderStateMixin {
  ProfileController profileController = Get.put(ProfileController());

  late Animation<double> animation;
  late AnimationController controller;

  late final OverlayEntry _overlayEntry;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: ANIMATION_DURATION_1000_MS, vsync: this);
    animation =
        CurvedAnimation(parent: controller, curve: Curves.linearToEaseOut)
          ..addListener(() {});
    _overlayEntry = OverlayEntry(
      builder: (context) {
        final size = MediaQuery.of(context).size;
        return SlideTransition(
          position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
              .animate(animation),
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
              const Text(
                "Hồ sơ",
                style: text24w700Blue,
              ),
              SizedBox(
                height: 10.sp,
              ),
              Row(
                children: [
                  CircleAvatar(
                    foregroundImage: NetworkImage(
                        AppController.userInfo.value?.avatar ?? ""),
                    backgroundImage:
                        const AssetImage(AssetsHelper.iconAvatarHolder),
                    radius: 20.sp,
                  ),
                  SizedBox(
                    width: 16.sp,
                  ),
                  Text(
                    AppController.userInfo.value?.fullname ?? "",
                    style: text14w500Blue,
                  ),
                ],
              ),
              SizedBox(
                height: 27.sp,
              ),
              const Text(
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
                      onConfirmed: () async {
                        await profileController.signOut();
                        await AppController().signOut();
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
          child: Obx(
            () => Visibility(
              visible: profileController.showSaveButton.value,
              child: SizedBox(
                width: 150.sp,
                height: 35.sp,
                child: InlineButton(
                  textColor: backgroundPrimaryColor,
                  isLoading: profileController.isSaving.value,
                  leading: null,
                  mainAxisSize: MainAxisSize.max,
                  onLongPress: null,
                  onTap: () {
                    profileController.savePreferences();
                  },
                  title: "Lưu",
                  textStyle: text14w700Blue,
                ),
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
            child: Obx(
              () => GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: profileController.topics.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (orientation == Orientation.portrait) ? 3 : 5,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 8,
                  childAspectRatio: 4 / 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return TopicReference(
                    isUserReference: profileController.selectedTopics
                        .contains(profileController.topics[index].id),
                    mainAxisSize: MainAxisSize.max,
                    title: profileController.topics[index].name,
                    onTap: () => profileController.selectTopic(
                      profileController.topics[index].id,
                    ),
                  );
                },
              ),
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
}
