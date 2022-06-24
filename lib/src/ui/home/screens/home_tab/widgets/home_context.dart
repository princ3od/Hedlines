import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedlines/src/configs/theme/app_colors.dart';
import 'package:hedlines/src/constants/args_key.dart';
import 'package:hedlines/src/controller/home/home_tab/home_tab_controller.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';
import 'package:hedlines/src/helper/utils/assets_helper.dart';
import 'package:hedlines/src/ui/common/buttons/inline_button.dart';
import 'package:hedlines/src/ui/home/screens/home_tab/widgets/icon_toogle.dart';
import 'package:hedlines/src/ui/styles/app_styles.dart';

import '../../../../../model/article.dart';

class HomeContext extends StatelessWidget {
  HomeContext({
    Key? key,
    required this.sizeScreen,
    required this.article,
  }) : super(key: key);

  final Size sizeScreen;
  final Article article;
  final HomeTabController homeTabController = Get.put(HomeTabController());

  @override
  Widget build(BuildContext context) {
    DateTime timeNow = DateTime.now();
    Duration diff = timeNow.difference(article.date);
    return Stack(
      children: [
        Column(
          children: [
            Image.network(
              article.thumbnail,
              width: sizeScreen.width,
              height: 180.sp,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${diff.inHours} giờ trước", style: text10w400Black),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 100.sp,
                    ),
                    child: Text(
                      article.title,
                      style: text24w700Black,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 100.sp,
                    ),
                    child: Text(
                      article.description,
                      style: text14w500Black,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
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
                          AppArgsKey.initialUrl: article.url,
                          AppArgsKey.title: "Xem tin (${article.estimateMinuteReadTime} phút đọc)",
                        };
                        homeTabController.toArticleDetial(args);
                      },
                      onLongPress: () {},
                      leading: null,
                      title: "Xem tin (${article.estimateMinuteReadTime} phút đọc)",
                      backgroundColor: backgroundPrimaryColor,
                      textStyle: text10w700White,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8, bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconToggleButton(
                pathImage: AssetsHelper.iconHeart,
                onTap: () {},
                onLongPress: () {},
                activeColor: backgroundPrimaryColor,
                inActiveColor: null,
              ),
              TextWrapper(text: article.numberOfFavorite.toString()),
              const SizedBox(
                height: 16,
              ),
              IconToggleButton(
                pathImage: AssetsHelper.iconShare,
                onTap: () {},
                onLongPress: () {},
                activeColor: null,
                inActiveColor: null,
              ),
              TextWrapper(text: article.numberOfShare.toString()),
              const SizedBox(
                height: 16,
              ),
              IconToggleButton(
                pathImage: AssetsHelper.iconEllypsisVertical,
                onTap: () {},
                onLongPress: () {},
                activeColor: null,
                inActiveColor: null,
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 70.w,
                    height: 24,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: InlineButton(
                              mainAxisSize: MainAxisSize.max,
                              horizontal: 2.sp,
                              onTap: null,
                              onLongPress: null,
                              leading: null,
                              title: article.tags[0] + " " + index.toString(),
                              textStyle: text10w400Blue,
                            ),
                          );
                        }),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${article.source["name"]}",
                          style: text14w700Blue,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "${article.topic["vnese"]}",
                          style: text10w400Black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
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
