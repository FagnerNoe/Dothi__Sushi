import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:dothi/colors/tema.dart';
import 'package:dothi/pages/cart.dart';
import 'package:dothi/pages/favorites.dart';
import 'package:dothi/pages/page_sushis.dart';
import 'package:dothi/pages/profile.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController(initialPage: 0);
  final NotchBottomBarController _controller = NotchBottomBarController(
    index: 0,
  );
  int maxCount = 4;

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> bottomBarPages = [
      SushiListScreen(),
      const Favorites(),
      const Cart(),
      const Profile(),
    ];
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          bottomBarPages.length,
          (index) => bottomBarPages[index],
        ),
      ),
      extendBody: true,
      bottomNavigationBar:
          (bottomBarPages.length <= maxCount)
              ? AnimatedNotchBottomBar(
                notchBottomBarController: _controller,
                color: const Color.fromARGB(255, 255, 255, 255),
                notchColor: Colors.black,
                maxLine: 1,
                shadowElevation: 0.3,
                kBottomRadius: 28.0,
                removeMargins: false,
                bottomBarWidth: 500,
                showShadow: true,
                durationInMilliSeconds: 300,
                elevation: 2,
                bottomBarItems: [
                  BottomBarItem(
                    inActiveItem: Icon(
                      Icons.home_filled,
                      color: const Color.fromARGB(255, 253, 198, 115),
                    ),

                    activeItem: Icon(
                      Icons.home_filled,

                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  BottomBarItem(
                    inActiveItem: Icon(
                      Icons.shopping_cart_outlined,
                      color: const Color.fromARGB(255, 253, 198, 115),
                    ),
                    activeItem: Icon(
                      Icons.shopping_bag_rounded,
                      color: dothiSushi.primaryColorLight,
                    ),
                  ),
                  BottomBarItem(
                    inActiveItem: Icon(
                      Icons.favorite_border_outlined,
                      color: const Color.fromARGB(255, 253, 198, 115),
                    ),
                    activeItem: Icon(
                      Icons.favorite,
                      color: dothiSushi.primaryColorLight,
                    ),
                  ),
                  BottomBarItem(
                    inActiveItem: Icon(
                      Icons.person_2_outlined,
                      color: const Color.fromARGB(255, 136, 135, 135),
                    ),
                    activeItem: Icon(
                      Icons.person,
                      color: dothiSushi.primaryColorLight,
                    ),
                  ),
                ],
                onTap: (index) {
                  print('current selected index $index');
                  _pageController.jumpToPage(index);
                },
                kIconSize: 20.0,
              )
              : null,
    );
  }
}
