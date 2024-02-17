import 'package:flutter/material.dart';
import 'package:github_followers/features/search/presentation/widgets/gf_item_info.dart';
import 'package:github_followers/features/search/presentation/widgets/gf_item_info_view.dart';

// ignore: must_be_immutable
class UserFollowers extends GFItemInfoView {
  const UserFollowers({
    Key? key,
    required String buttonTitle,
    required Color buttonColor,
    required ItemInfoType type1,
    required ItemInfoType type2,
    required int type1Count,
    required int type2Count,
    required VoidCallback onButtonTapped,
  }) : super(
          key: key,
          buttonTitle: buttonTitle,
          buttonColor: buttonColor,
          type1: type1,
          type2: type2,
          type1Count: type1Count,
          type2Count: type2Count,
          onButtonTapped: onButtonTapped,
        );
}
