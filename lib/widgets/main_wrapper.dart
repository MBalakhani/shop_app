import 'package:flutter/material.dart';
import 'package:shop_application/widgets/bottom_nav.dart';

import '../featuers/featuer_home/screens/home_screen.dart';
import '../featuers/featuer_home/screens/profile_screen.dart';
import '../featuers/feature_product/screens/category_screen.dart';

// ignore: must_be_immutable
class MainWrapper extends StatelessWidget {
  static const routeName = "/main_wrapper";

  MainWrapper({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  PageController pageController = PageController();

  List<Widget> topLevelScreens = [
    const HomeScreen(),
    const CategoryScreen(),
    ProfileScreen(),
    Container(
      color: Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(controller: pageController),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),

            /// search Box
            // Container(
            //   decoration: BoxDecoration(color: Colors.white, boxShadow: [
            //     BoxShadow(
            //         blurRadius: 2,
            //         color: Colors.grey.shade400,
            //         offset: const Offset(0, 3))
            //   ]),
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 10.0,right: 10, bottom: 10),
            //     child: SearchTextField(controller: searchController, allProductsRepository: locator<AllProductsRepository>(),),
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),

            Expanded(
              child: PageView(
                controller: pageController,
                children: topLevelScreens,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
