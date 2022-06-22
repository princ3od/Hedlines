import 'package:hedlines/src/model/topic.dart';

class AssetsHelper {
  static const String logo = "assets/images/svg/logo_hedlines.svg";

  //Auth
  static const String icoGoogle = "assets/images/svg/google_ico.svg";

  //Home

  static const String iconHome = "assets/images/svg/home_ico.svg";
  static const String iconHomeActive = "assets/images/svg/homeActive_ico.svg";
  static const String iconProfile = "assets/images/svg/profile_ico.svg";
  static const String iconProfileActive =
      "assets/images/svg/profileActive_ico.svg";
  static const String iconSearch = "assets/images/svg/search_ico.svg";
  static const String iconSearchActive =
      "assets/images/svg/searchActive_ico.svg";
  static const String iconHeart = "assets/images/svg/heart_ico.svg";
  static const String iconFavourite = "assets/images/svg/favourite_ico.svg";
  static const String iconEllypsisVertical =
      "assets/images/svg/ellypsis_vertical_ico.svg";
  static const String iconShare = "assets/images/svg/share_ico.svg";
  static const String iconAvatarHolder = "assets/icons/avatar_holder_ico.png";

  //HomeOverlay
  static const String iconSwipeUp = "assets/images/svg/swipe_up_ico.svg";

  // Topic
  static String getTopicIcon(Topic topic) =>
      "assets/images/svg/${topic.id}.svg";
}
