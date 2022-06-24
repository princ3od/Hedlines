import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedlines/src/configs/lang/localization.dart';
import 'package:hedlines/src/configs/theme/app_colors.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';
import 'package:hedlines/src/ui/home/screens/search_tab/widgets/list_topic.dart';

import '../../../../../controller/home/search_tab/search_tab_controller.dart';

class SearchBar extends StatelessWidget {
  final pink = const Color(0xFFFACCCC);
  final grey = const Color(0xFFF2F2F7);

  final SearchTabController searchTabController = Get.find();

  SearchBar({Key? key}) : super(key: key);
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
            controller: searchTabController.textEditingController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              focusColor: pink,
              focusedBorder: _border(Colors.amber),
              border: _border(backgroundPrimaryColor),
              enabledBorder: _border(backgroundPrimaryColor),
              hintText: Strings.startSearch.i18n,
              contentPadding: const EdgeInsets.symmetric(vertical: 20),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
            onChanged: searchTabController.onSearchTextChange,
            onFieldSubmitted: (value) {},
            onTap: () {
              searchTabController.onSearchForcus();
            },
          ),
          SizedBox(
            height: 16.sp,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 24.sp,
            child: ListTopic(
              searchTabController: searchTabController,
            ),
          )
        ],
      ),
    );
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderSide: BorderSide(width: 1.sp, color: color),
        borderRadius: BorderRadius.circular(5.sp),
      );
}
