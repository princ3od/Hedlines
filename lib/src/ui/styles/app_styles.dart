import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hedlines/src/helper/sizer_custom/sizer.dart';

final AppBar appBarCalendar = AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0.0,
  systemOverlayStyle: SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
  ),
);

final Divider dividerCalendar = Divider(
  color: colorDividerTimeline,
  thickness: 0.2.sp,
  height: 0.2.sp,
  indent: 10.sp,
  endIndent: 12.sp,
);

final Widget dividerThinkness6 = Container(
  height: 6.sp,
  color: backgroundDetails,
  margin: EdgeInsets.only(top: 2.sp, bottom: 10.sp),
);

final Widget dividerThinkness6NotMargin = Container(
  height: 6.sp,
  color: backgroundDetails,
);

const Color colorGray1 = Color(0xFF6E6D7A);
const Color colorGray2 = Color(0xFFACACB9);
const Color colorBlack1 = Color(0xFF0D0C22);
const Color colorBlack2 = Color(0xFF3D3D4E);

const Color colorGreen2 = Color(0xFF2B6B64);
const Color colorGreen3 = Color(0xFF5EA199);
const Color colorGreen4 = Color(0xffBAD7C9);
const Color colorGreen5 = Color(0xFFE2F0E9);
const Color colorGreenTimeline = Color(0xFF59ADA4);
const Color colorStatusTimeline = Color(0xFF167BA7);
const Color colorTimelineCardShimmer = Color(0xFFFAFAFA);
const Color colorBorderPicked = Color(0xFF2B6B64);
const Color colorDividerTimeline = Color(0xFFC5D0CF);
const Color colorDotBelowDate = Color(0xFFBAD8C9);
const Color headerCalendarColor = Color(0xFF1C4843);
const Color backgroundCalendarCardGray = Color(0xFFE5E5E5);
const Color backgroundCalendarCardYellow = Color(0xFFEFF1E0);
const Color backgroundTimelineDone = Color(0xFFF9F9F9);
const Color backgroundNotification = Color(0xFFF0F6F6);
const Color backgroundDetails = Color(0xFFF5F5F5);
const Color colorProcessing = Color(0xFFFFB800);

const colorBackgroundBadges = Color(0xFFF6C8AB);
const colorGrayBorder = Color(0xFFC5C5D0);
const colorBlack4 = Color(0xFFA9AAB8);
const colorBlack3 = Color(0xFF333333);
const colorCaptionSearch = Color(0xFFA3A3A3);
const colorTextChatCard = Color(0xFF53596F);
const colorTimeChat = Color(0xFF9897A0);
const colorBackgroundReceiver = Color(0xFFE2F0E9);
const colorBackgroundSender = Color(0xFFF1F1F1);
const colorTextSender = Color(0xFF53596F);
const colorTextAppointmentCard = Color(0xFFFDFDFD);
const colorFontGreen = Color(0xFF1C4843);
const colorDelete = Color(0xFFFE5252);
const colorMoreChat = Color(0xFF6E6E7A);
const colorBackgroundCall = Color(0xFFE9F4EE);
const colorBackgroundReceiverInCall = Color(0xFF393D4F);
const colorHintTextInCall = Color(0xFF9897A0);

const Color colorAddButton = Color(0xFFF0F6F6);
const Color colorFinished = Color(0xFFB31D1D);
const Color colorRequestCard = Color(0xFFFFFFFF);
const Color colorFocusItemDropdown = Color(0xFFE2F0E9);
const Color colorGrey3 = Color(0xFFE3E3E3);
const Color colorChosen = Color(0xFF167BA7);
const Color colorChosenCard = Color(0xFFF0F6F6);
const Color colorNotChosenCard = Color(0xFFF7E8E8);

const colorWhite = Color(0xFFFFFFFF);
const colorDisalbeTimeButton = Color(0xFFF5F5F5);

const colorDialogBackGround = Color(0xFFFFFFFF);
// Assets

// Height-width ratio
final isLargeDevice = 100.h / 100.w > 1.6;
final TextStyle text13w400cBlack2 = TextStyle(
  fontSize: 13.sp,
  fontWeight: FontWeight.w400,
  color: colorBlack2,
);
final TextStyle text14w600cBlack2 = TextStyle(
  fontSize: 14.sp,
  fontWeight: FontWeight.w600,
  color: colorBlack2,
);
final TextStyle text14w700cBlack1 = TextStyle(
  fontSize: 14.sp,
  fontWeight: FontWeight.w700,
  color: colorBlack1,
);
final TextStyle text14w700cBlack2 = TextStyle(
  fontSize: 14.sp,
  fontWeight: FontWeight.w700,
  color: colorBlack2,
);
final TextStyle text12w600cBlack2 = TextStyle(
  fontSize: 12.sp,
  fontWeight: FontWeight.w600,
  color: colorBlack2,
);
final TextStyle text12w400cFontGreen = TextStyle(
  fontSize: 12.sp,
  fontWeight: FontWeight.w400,
  color: colorFontGreen,
);
final TextStyle text12w400cFinished = TextStyle(
  fontSize: 12.sp,
  fontWeight: FontWeight.w400,
  color: colorFinished,
);
final TextStyle text13w600cBlack2 = TextStyle(
  fontSize: 13.sp,
  fontWeight: FontWeight.w600,
  color: colorBlack2,
);
final TextStyle text13w700cWhite = TextStyle(
  fontSize: 13.sp,
  fontWeight: FontWeight.w700,
  color: colorWhite,
);

final TextStyle text10w400cGray2 = TextStyle(
  fontSize: 10.sp,
  fontWeight: FontWeight.w400,
  color: colorGray2,
);
final TextStyle text13w400cGray2 = TextStyle(
  fontSize: 13.sp,
  fontWeight: FontWeight.w400,
  color: colorGray2,
);
final TextStyle text15w700cBlack2 = TextStyle(
  fontSize: 15.sp,
  fontWeight: FontWeight.w700,
  color: colorBlack2,
);
final TextStyle text13w700cGray1 = TextStyle(
  fontSize: 13.sp,
  fontWeight: FontWeight.w700,
  color: colorGray1,
);
final TextStyle text13w400cGreen2 = TextStyle(
  fontSize: 13.sp,
  fontWeight: FontWeight.w400,
  color: colorGreen2,
);
final TextStyle text13w400cFontGreen = TextStyle(
  fontSize: 13.sp,
  fontWeight: FontWeight.w400,
  color: colorFontGreen,
);
final TextStyle text13w400cRed = TextStyle(
  fontSize: 13.sp,
  fontWeight: FontWeight.w400,
  color: Color(0xffB31D1D),
);

final TextStyle tex56w400Blue = TextStyle(
  fontSize: 53.sp,
  fontWeight: FontWeight.w400,
  letterSpacing: 1,
  color: Color(0xff0953AD),
  fontStyle: FontStyle.normal,
);
final TextStyle tex20w400Blue = TextStyle(
  fontSize: 17.sp,
  fontWeight: FontWeight.w400,
  color: Color(0xff0953AD),
  fontStyle: FontStyle.normal,
);

final TextStyle tex14w500Blue = TextStyle(
  fontSize: 12.sp,
  fontWeight: FontWeight.w500,
  color: Color(0xff0953AD),
  fontStyle: FontStyle.normal,
);

final TextStyle text24w700Blue = TextStyle(
  fontSize: 21.sp,
  fontWeight: FontWeight.w700,
  color: Color(0xff0953AD),
  fontStyle: FontStyle.normal,
);

final TextStyle text14w500Blue = TextStyle(
  fontSize: 11.sp,
  fontWeight: FontWeight.w500,
  color: Color(0xff0953AD),
  fontStyle: FontStyle.normal,
);
