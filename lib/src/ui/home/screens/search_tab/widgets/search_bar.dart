import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedlines/src/configs/theme/app_colors.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';
import 'package:hedlines/src/ui/common/buttons/inline_button.dart';
import 'package:hedlines/src/ui/styles/app_styles.dart';

import '../../../../../controller/home/search_tab/search_tab_controller.dart';
import '../../../../../helper/utils/assets_helper.dart';

class SearchBar extends StatelessWidget {
  final pink = const Color(0xFFFACCCC);
  final grey = const Color(0xFFF2F2F7);
  final List<Map<String, String>> gridData = [
    {
      'lable': "Kinh doanh",
      'image': AssetsHelper.iconworkingbag,
    },
    {
      'lable': 'Giải trí',
      'image': AssetsHelper.iconemojismile,
    },
    {
      'lable': 'Thời sự',
      'image': AssetsHelper.iconglobal,
    },
    {
      'lable': 'Du lịch',
      'image': AssetsHelper.iconairbalonhottravel,
    },
    {
      'lable': 'Thể thao',
      'image': AssetsHelper.icontrophy,
    },
    {
      'lable': 'Công nghệ',
      'image': AssetsHelper.iconmonitor,
    }
  ];
  final SearchTabController searchTabController = Get.find();
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: 280.sp,
      ),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              focusColor: pink,
              focusedBorder: _border(Colors.amber),
              border: _border(backgroundPrimaryColor),
              enabledBorder: _border(backgroundPrimaryColor),
              hintText: 'Start search',
              contentPadding: const EdgeInsets.symmetric(vertical: 20),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
            onChanged: searchTabController.onSearchTextChange,
            onFieldSubmitted: (value) {},
          ),
          SizedBox(
            height: 16.sp,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 24.sp,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return SizedBox(
                    child: _buildListItem(index),
                    width: 80.sp,
                  );
                }),
          )
        ],
      ),
    );
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderSide: BorderSide(width: 1.sp, color: color),
        borderRadius: BorderRadius.circular(5.sp),
      );

  Widget _buildListItem(int index) {
    return Container(
      margin: index != 0 ? EdgeInsets.only(left: 8.sp) : EdgeInsets.zero,
      child: InlineButton(
        onTap: null,
        onLongPress: null,
        leading: null,
        title: gridData[index]["lable"] ?? "",
        mainAxisSize: MainAxisSize.min,
        textStyle: text10w400Blue,
      ),
    );
  }
}
