import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/profile_list_model.dart';
import '../widgets/profile_list_tile.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  List<ProfileListModel> profileList = [
    ProfileListModel(
        iconData: Icons.person, title: "حساب کاربری شخصی", onTap: () {}),
    ProfileListModel(
        iconData: Icons.shopping_bag_outlined,
        title: "حساب کاربری فروشگاهی",
        onTap: () {}),
    ProfileListModel(
        iconData: CupertinoIcons.archivebox_fill,
        title: "سفارشات",
        onTap: () {}),
    ProfileListModel(iconData: Icons.home_work, title: "آدرس من", onTap: () {}),
    ProfileListModel(
        iconData: Icons.support_agent, title: "پشتیبانی", onTap: () {}),
    ProfileListModel(
        iconData: Icons.exit_to_app, title: "خروج از حساب", onTap: () {}),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: profileList.length,
            itemBuilder: (context, index) {
              return ProfileListTile(
                  iconData: profileList[index].iconData,
                  title: profileList[index].title,
                  onTap: profileList[index].onTap,
                  isLast: (index == profileList.length - 1) ? true : false);
            }),
      ],
    );
  }
}
