import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hedlines/src/configs/theme/app_colors.dart';
import 'package:hedlines/src/controller/topic/topic_controller.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';
import 'package:hedlines/src/helper/utils/assets_helper.dart';
import 'package:hedlines/src/ui/common/app_bars/app_bar_brighness_dark.dart';
import 'package:hedlines/src/ui/common/buttons/inline_button.dart';
import 'package:hedlines/src/ui/styles/app_styles.dart';
import 'package:hedlines/src/ui/topic/widgets/field_concern.dart';

class TopicScreen extends StatefulWidget {
  const TopicScreen({Key? key}) : super(key: key);

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  var topicController = Get.put(TopicController());
  Set<String> topicChoose = {};
  bool isError = false;
  @override
  Widget build(BuildContext context) {
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
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: appBarBrighnessDark(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40.sp,
                width: 261.sp,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Bạn quan tâm về\nchủ đề gì?",
                  style: text24w700Blue,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 14.sp,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Chọn 2 trong 6 chủ đề dưới đây.",
                  style: text14w500Blue,
                ),
              ),
              SizedBox(
                height: 56.sp,
              ),
              Expanded(
                flex: 3,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: gridData.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (orientation == Orientation.portrait) ? 3 : 5,
                    mainAxisSpacing: (orientation == Orientation.portrait) ? 16.sp : 10.sp,
                    crossAxisSpacing: (orientation == Orientation.portrait) ? 0.sp : 5.sp,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return FieldConcern(
                      onTap: () {
                        String? topic = gridData[index]['lable'];
                        if (topic != null) {
                          _toggleTopic(topic);
                        }
                      },
                      iconFiledConcern: gridData[index]["image"] ?? AssetsHelper.logo,
                      lable: gridData[index]["lable"] ?? "Hedlines",
                    );
                  },
                ),
              ),
              SizedBox(
                height: 4.sp,
              ),
              Visibility(
                visible: isError,
                child: Text(
                  topicChoose.isEmpty ? "Bạn chưa chọn chủ đề nào." : "Bạn phải chọn ít nhất 2 chủ đề.",
                  style: text13w400cRed,
                ),
              ),
              SizedBox(
                height: 25.sp,
              ),
              InlineButton(
                mainAxisSize: MainAxisSize.max,
                onTap: () {
                  _checkNumberSelectedTopic();
                  if (!isError) {
                    topicController.handelNagivateToHome(topicChoose);
                  }
                },
                onLongPress: null,
                leading: null,
                title: "TIẾP TỤC",
                backgroundColor: backgroundPrimaryColor,
                textColor: colorWhite,
              ),
              Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //internal function
  _checkNumberSelectedTopic() {
    if (topicChoose.isEmpty || topicChoose.length < 2) {
      setState(() {
        isError = true;
      });
    } else {
      setState(() {
        isError = false;
      });
    }
  }

  _toggleTopic(String topic) {
    setState(() {
      if (topicChoose.contains(topic)) {
        topicChoose.remove(topic);
      } else {
        topicChoose.add(topic);
      }
    });
    _checkNumberSelectedTopic();
  }
}
