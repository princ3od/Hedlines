import 'package:flutter/material.dart';
import 'package:hedlines/src/constants/constants.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';
import 'package:hedlines/src/ui/home/screens/search_tab/widgets/bar_title.dart';
import 'package:hedlines/src/ui/styles/app_styles.dart';

import 'search_bar.dart';

class SliverSearchAppBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var adjustedShrinkOffset =
        shrinkOffset > minExtent ? minExtent : shrinkOffset;
    double offset = (minExtent - adjustedShrinkOffset) * 0.5;
    double topPadding = MediaQuery.of(context).padding.top + 16.sp;
    return Stack(children: [
      SizedBox(
        height: 300,
        child: ClipPath(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            decoration: const BoxDecoration(
              color: colorWhite,
            ),
          ),
        ),
      ),
      Positioned(
        top: topPadding + offset - 30,
        left: 12,
        child: AnimatedOpacity(
          duration: ANIMATION_DURATION_500_MS,
          opacity: adjustedShrinkOffset.toInt() > 0 ? 0 : 1,
          child: const BarTitle(
            title: 'Tìm kiếm',
            style: text24w700Blue,
          ),
        ),
      ),
      Positioned(
        top: topPadding + offset,
        child: SearchBar(),
        left: 13.sp,
        right: 13.sp,
      ),
    ]);
  }

  @override
  double get maxExtent => 300;

  @override
  double get minExtent => 200;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.maxExtent != maxExtent ||
        oldDelegate.minExtent != minExtent;
  }
}
