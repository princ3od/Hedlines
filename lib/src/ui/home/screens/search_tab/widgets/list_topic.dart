import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';

import '../../../../../configs/theme/app_colors.dart';
import '../../../../../controller/home/search_tab/search_tab_controller.dart';
import '../../../../common/buttons/touchable_opacity.dart';
import '../../../../styles/app_styles.dart';

class ListTopic extends StatefulWidget {
  const ListTopic({Key? key, required this.searchTabController}) : super(key: key);
  final SearchTabController searchTabController;

  @override
  State<ListTopic> createState() => _ListTopicState();
}

class _ListTopicState extends State<ListTopic> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.searchTabController.topics.value?.length ?? 0,
        itemBuilder: (context, index) {
          return SizedBox(
            child: Container(
              margin: index != 0 ? EdgeInsets.only(left: 8.sp) : EdgeInsets.zero,
              child: TouchableOpacity(
                onTap: () {
                  widget.searchTabController.isCardEnabled.replaceRange(0, widget.searchTabController.isCardEnabled.length, [for (int i = 0; i < widget.searchTabController.isCardEnabled.length; i++) false]);
                  widget.searchTabController.isCardEnabled[index] = true;
                  setState(() {});
                  widget.searchTabController.onTopicClick(index);
                },
                onLongPress: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.sp),
                  height: 45.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.sp),
                    color: widget.searchTabController.isCardEnabled[index] ? backgroundPrimaryColor : Colors.transparent,
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Text(
                        widget.searchTabController.topics.value![index].name,
                        style: text10w400Blue.copyWith(
                          color: widget.searchTabController.isCardEnabled[index] ? colorWhite : const Color(0xff0953AD),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            width: 80.sp,
          );
        },
      );
    });
  }
}
