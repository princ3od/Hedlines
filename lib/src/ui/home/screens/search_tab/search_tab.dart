import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedlines/src/controller/home/search_tab/search_tab_controller.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';
import 'package:hedlines/src/ui/common/buttons/touchable_opacity.dart';
import 'package:hedlines/src/ui/home/screens/search_tab/widgets/sliver_search_appbar.dart';
import 'package:hedlines/src/ui/styles/app_styles.dart';
import '../../../../model/fake_model/article_description.dart';
import 'package:intl/intl.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final SearchTabController controller = Get.put(SearchTabController());
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: SliverSearchAppBar(),
          pinned: true,
        ),
        GetBuilder<SearchTabController>(
          builder: (controller) => SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 4.sp),
                  padding: EdgeInsets.symmetric(horizontal: 13.sp),
                  child: _buildSearchItem(controller.searchedArticles[index], index),
                );
              },
              childCount: controller.searchedArticles.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchItem(Article article, int index) {
    return TouchableOpacity(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  article.source["name"],
                  style: text24w700Black,
                ),
                const Spacer(),
                Text(
                  DateFormat('dd-MM-yyyy').format(article.publishedAt),
                  style: text14w500Grey,
                ),
              ],
            ),
            SizedBox(
              height: 16.sp,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  article.thumbnail,
                  height: 85.sp,
                  width: 130.sp,
                  fit: BoxFit.cover,
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
