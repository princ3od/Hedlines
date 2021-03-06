import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedlines/src/configs/theme/app_colors.dart';
import 'package:hedlines/src/controller/home/home_controller.dart';
import 'package:hedlines/src/controller/home/home_tab/home_tab_controller.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';
import 'package:hedlines/src/helper/utils/assets_helper.dart';
import 'package:hedlines/src/ui/common/buttons/inline_button.dart';
import 'package:hedlines/src/ui/common/full_screen_image/full_screen_image.dart';
import 'package:hedlines/src/ui/styles/app_styles.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../../model/article.dart';

class HomeContext extends StatefulWidget {
  const HomeContext({
    Key? key,
    required this.sizeScreen,
    required this.article,
    this.onToDetail,
  }) : super(key: key);

  final Size sizeScreen;
  final Article? article;
  final Function? onToDetail;

  @override
  State<HomeContext> createState() => _HomeContextState();
}

class _HomeContextState extends State<HomeContext> {
  final HomeTabController homeTabController = Get.put(HomeTabController());

  bool showDateInDetial = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            GestureDetector(
              onTap: () {
                Get.to(FullImageScreen(
                  tag: widget.article?.thumbnail ??
                      'https://source.unsplash.com/random',
                  imageURL: widget.article?.thumbnail ??
                      'https://source.unsplash.com/random',
                ));
              },
              child: Hero(
                tag: widget.article?.url ?? Random().nextInt(100).toString(),
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, 0.4],
                      colors: [Colors.grey.withOpacity(.9), Colors.transparent],
                    ).createShader(
                        Rect.fromLTRB(0, 0, rect.width, rect.height));
                  },
                  blendMode: BlendMode.srcOver,
                  child: Image.network(
                    widget.article?.thumbnail ??
                        'https://source.unsplash.com/random',
                    width: widget.sizeScreen.width,
                    height: 180.sp,
                    fit: BoxFit.cover,
                    errorBuilder: (context, url, error) {
                      return Image.asset(
                        AssetsHelper.placeholderThumbnail,
                        width: widget.sizeScreen.width,
                        height: 180.sp,
                        fit: BoxFit.cover,
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 180.sp,
                          width: widget.sizeScreen.width,
                          color: Colors.grey[300]!,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showDateInDetial = !showDateInDetial;
                      });
                    },
                    child: Text(
                        showDateInDetial
                            ? DateFormat('EEEE, dd/MM/yyyy - HH:mm').format(
                                widget.article?.date ??
                                    DateTime.now()
                                        .subtract(const Duration(hours: 8)))
                            : timeago.format(
                                widget.article?.date ??
                                    DateTime.now()
                                        .subtract(const Duration(hours: 8)),
                                locale: 'vi'),
                        style: text12w400Black),
                  ),
                  Text(
                    widget.article?.title ??
                        'Nga n??i Ukraine ph???i ch???p thu???n m???i y??u c???u ????? h??a b??nh',
                    style: text24w700Black,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.article?.description ??
                        "Ph??t ng??n vi???n ??i???n Kremlin Peskov n??i Ukraine ph???i ch???p thu???n m???i y??u c???u c???a Nga n???u mu???n d???ng chi???n s??? k??o d??i 4 th??ng.",
                    style: text14w500Black,
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
                      onTap: widget.onToDetail ??
                          () {
                            HomeController homeController =
                                Get.find<HomeController>();
                            homeController.toArticleDetail();
                          },
                      onLongPress: () {},
                      leading: null,
                      title:
                          "Xem tin (${widget.article?.estimateMinuteReadTime ?? 2} ph??t ?????c)",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LikeButton(
                    circleColor: CircleColor(
                        start: backgroundPrimaryColor,
                        end: backgroundPrimaryColor),
                    bubblesColor: BubblesColor(
                      dotPrimaryColor: backgroundPrimaryColor,
                      dotSecondaryColor: backgroundPrimaryColor,
                    ),
                    isLiked: widget.article?.isLiked ?? false,
                    onTap: (isLiked) async {
                      homeTabController.likeArticle(isLiked,
                          article: widget.article);
                      return !isLiked;
                    },
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        isLiked
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_outlined,
                        color: backgroundPrimaryColor,
                        size: 32,
                      );
                    },
                    likeCount: widget.article?.numberOfFavorite ?? 0,
                    countPostion: CountPostion.bottom,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    countBuilder: (int? count, bool isLiked, String text) {
                      var color =
                          isLiked ? backgroundPrimaryColor : Colors.grey;

                      return Text(
                        text,
                        style: TextStyle(color: color),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LikeButton(
                    size: 32,
                    circleColor: CircleColor(
                        start: backgroundPrimaryColor,
                        end: backgroundPrimaryColor),
                    bubblesColor: BubblesColor(
                      dotPrimaryColor: backgroundPrimaryColor,
                      dotSecondaryColor: backgroundPrimaryColor,
                    ),
                    onTap: (tapped) async {
                      Share.share(
                          '${widget.article!.title} - ${widget.article!.url}');
                      return true;
                    },
                    isLiked: widget.article?.isLiked ?? false,
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        isLiked ? Icons.share_rounded : Icons.share_outlined,
                        color: backgroundPrimaryColor,
                        size: 32,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 65.w,
                    height: 24,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.article?.tags.length ?? 1,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: InlineButton(
                              mainAxisSize: MainAxisSize.max,
                              horizontal: 2.sp,
                              onTap: null,
                              onLongPress: null,
                              leading: null,
                              title: widget.article?.tags[index]["tag"] ??
                                  "Urkaine",
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
                          "${widget.article?.source["name"] ?? "Ngu???n b??o"}",
                          style: text14w700Blue,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "${widget.article?.topic["vnese"] ?? "Ch??? ?????"}",
                          style: text12w400Black,
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
