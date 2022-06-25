import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedlines/src/configs/theme/app_colors.dart';
import 'package:hedlines/src/controller/home/search_tab/search_tab_controller.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';
import 'package:hedlines/src/helper/utils/assets_helper.dart';
import 'package:hedlines/src/ui/common/buttons/touchable_opacity.dart';
import 'package:hedlines/src/ui/home/screens/search_tab/widgets/sliver_search_appbar.dart';
import 'package:hedlines/src/ui/styles/app_styles.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../model/article.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final SearchTabController controller = Get.put(SearchTabController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: (_) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: SliverSearchAppBar(),
            pinned: true,
          ),
          GetBuilder<SearchTabController>(builder: (controller) {
            if (controller.searchedArticles.value!.isEmpty &&
                !controller.isLoading.value) {
              return SliverToBoxAdapter(
                child: _buidSearchEmpty(),
              );
            }

            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return controller.isLoading.value
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 4.sp),
                            padding: EdgeInsets.symmetric(horizontal: 13.sp),
                            child: _buildSearchItem(
                                controller.searchedArticles.value![index],
                                index),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.symmetric(vertical: 4.sp),
                          padding: EdgeInsets.symmetric(horizontal: 13.sp),
                          child: _buildSearchItem(
                              controller.searchedArticles.value![index], index),
                        );
                },
                childCount: controller.searchedArticles.value?.length ?? 0,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buidSearchEmpty() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 120,
        ),
        SvgPicture.asset(
          AssetsHelper.iconSearch,
          color: backgroundPrimaryColor,
          width: 75,
          height: 75,
        ),
        const Text(
          "Xin lỗi, chúng tôi không tìm \nthấy kết quả nào",
          style: text14w500Black,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSearchItem(Article article, int index) {
    return TouchableOpacity(
      onTap: () {
        controller.onOpenArticle(article.id);
      },
      child: SizedBox(
        width: 339.sp,
        height: 136.sp,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index > 0)
              Divider(
                color: colorDividerTimeline,
                thickness: 0.5.sp,
                height: 0.5.sp,
              ),
            if (index > 0) SizedBox(height: 4.sp),
            Text(
              article.title,
              style: text14w500Black,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 4.sp,
            ),
            Text(
              DateFormat('dd-MM-yyyy').format(article.date),
              style: text14w500Grey,
            ),
            SizedBox(
              height: 8.sp,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  article.thumbnail,
                  height: 85.sp,
                  width: 130.sp,
                  fit: BoxFit.cover,
                  errorBuilder: (context, url, error) {
                    return Image.asset(
                      AssetsHelper.placeholderThumbnail,
                      height: 85.sp,
                      width: 130.sp,
                      fit: BoxFit.cover,
                    );
                  },
                ),
                SizedBox(
                  width: 8.sp,
                ),
                SizedBox(
                  child: Text(
                    article.description,
                    style: text14w500Grey,
                    overflow: TextOverflow.clip,
                  ),
                  width: 120.sp,
                  height: 85.sp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
