import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_space_01/constants/assets_constants.dart';
import 'package:safe_space_01/features/explore/view/explore_view.dart';
import 'package:safe_space_01/features/notifications/views/notification_view.dart';
import 'package:safe_space_01/features/tweet/widgets/tweet_list.dart';
import 'package:safe_space_01/theme/theme.dart';

class UiConstants {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        color: Pallete.blueColor,
        height: 30,
      ),
      centerTitle: true,
    );
  }

  static const List<Widget> bottomTabBarPages = [
    TweetList(),
    ExploreView(),
    NotificationView(),
  ];
}
