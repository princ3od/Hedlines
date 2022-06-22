import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedlines/src/configs/theme/app_colors.dart';
import 'package:hedlines/src/constants/args_key.dart';
import 'package:hedlines/src/controller/home/home_tab/home_tab_controller.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';
import 'package:hedlines/src/helper/utils/assets_helper.dart';
import 'package:hedlines/src/model/fake_model/article_description.dart';
import 'package:hedlines/src/ui/common/buttons/inline_button.dart';
import 'package:hedlines/src/ui/home/screens/home_tab/widgets/icon_toogle.dart';
import 'package:hedlines/src/ui/styles/app_styles.dart';

class HomeContext extends StatelessWidget {
  HomeContext({
    Key? key,
    required this.sizeScreen,
    required this.articleDescription,
  }) : super(key: key);

  final Size sizeScreen;
  final Article articleDescription;
  final HomeTabController homeTabController = Get.put(HomeTabController());

  @override
  Widget build(BuildContext context) {
    DateTime timeNow = DateTime.now();
    Duration diff = timeNow.difference(articleDescription.date);
    return SafeArea(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.network(
              articleDescription.thumbnail,
              width: sizeScreen.width,
              height: 140.sp,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 157.sp,
                ),
                Text("${diff.inHours} giờ trước", style: text10w400Black),
                Text(
                  "${articleDescription.title}",
                  style: text24w700Black,
                ),
                SizedBox(
                  height: 8.sp,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 100.sp,
                  ),
                  child: Text(
                    articleDescription.description,
                    style: text14w500Black,
                  ),
                ),
                SizedBox(
                  height: 29.sp,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 37.sp,
                    maxWidth: 140.sp,
                  ),
                  child: InlineButton(
                    mainAxisSize: MainAxisSize.min,
                    onTap: () {
                      dynamic args = {
                        AppArgsKey.initialUrl: articleDescription.url,
                        AppArgsKey.title: "Xem tin (${articleDescription.estimateMinuteReadTime} phút đọc)",
                      };
                      homeTabController.handleTransactionPage(args);
                    },
                    onLongPress: () {},
                    leading: null,
                    title: "Xem tin (${articleDescription.estimateMinuteReadTime} phút đọc)",
                    backgroundColor: backgroundPrimaryColor,
                    textStyle: text10w700White,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: SizedBox(
              height: 234.sp,
              width: 76,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Spacer(),
                  IconToggleButton(
                    pathImage: AssetsHelper.iconHeart,
                    onTap: () {},
                    onLongPress: () {},
                    activeColor: backgroundPrimaryColor,
                    inActiveColor: null,
                  ),
                  TextWrapper(text: articleDescription.numberOfFavorite.toString()),
                  const Spacer(),
                  IconToggleButton(
                    pathImage: AssetsHelper.iconShare,
                    onTap: () {},
                    onLongPress: () {},
                    activeColor: null,
                    inActiveColor: null,
                  ),
                  TextWrapper(text: articleDescription.numberOfShare.toString()),
                  // Text("${articleDescription.numberOfShare}"),
                  const Spacer(),
                  IconToggleButton(
                    pathImage: AssetsHelper.iconEllypsisVertical,
                    onTap: () {},
                    onLongPress: () {},
                    activeColor: null,
                    inActiveColor: null,
                  ),
                  const Spacer(),
                  Text(
                    "${articleDescription.source["name"]}",
                    style: text14w700Blue,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 4.sp,
                  ),
                  Text(
                    "${articleDescription.topic["vnese"]}",
                    style: text10w400Black,
                  ),
                  const Spacer(),
                ],
              ),
            ),
            top: sizeScreen.height - 314.sp,
            left: sizeScreen.width - 76.sp,
          ),
          Positioned(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
              child: SizedBox(
                height: 234.sp,
                child: Column(
                  children: [
                    const Spacer(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 72.sp,
                          child: InlineButton(
                            mainAxisSize: MainAxisSize.min,
                            horizontal: 2.sp,
                            height: 24.sp,
                            onTap: null,
                            onLongPress: null,
                            leading: null,
                            title: articleDescription.tags[0],
                            textStyle: text10w400Blue,
                          ),
                        ),
                        SizedBox(
                          width: 8.sp,
                        ),
                        SizedBox(
                          width: 72.sp,
                          child: InlineButton(
                            mainAxisSize: MainAxisSize.min,
                            horizontal: 2.sp,
                            height: 24.sp,
                            onTap: null,
                            onLongPress: null,
                            leading: null,
                            title: articleDescription.tags[1],
                            textStyle: text10w400Blue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24.sp,
                    )
                  ],
                ),
              ),
            ),
            top: sizeScreen.height - 314.sp,
          ),
        ],
      ),
    );
  }
}

class TextWrapper extends StatelessWidget {
  final String text;
  const TextWrapper({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 24.sp,
        child: Center(
          child: Text(
            text,
          ),
        ));
  }
}
