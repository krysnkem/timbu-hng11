import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shop_bag_app/screens/checkout_page.dart';
import 'package:shop_bag_app/screens/my_cart.dart';
import 'package:shop_bag_app/screens/products_listing.dart';
import 'package:shop_bag_app/utils/bottom_nav_bar_icons.dart';
import 'package:shop_bag_app/utils/colors.dart';
import 'package:shop_bag_app/utils/extensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: onSwipePage,
        children: [
          const ProductsListing(),
          MyCart(
            showProductListing: () {
              onChangeDestination(0);
            },
          ),
          const CheckoutPage(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: 65,
            child: NavigationBar(
              onDestinationSelected: onChangeDestination,
              indicatorColor: accentColor,
              backgroundColor: mainBlack,
              selectedIndex: _currentIndex,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              indicatorShape: const CircleBorder(),
              destinations: <Widget>[
                const NavigationDestination(
                  selectedIcon: Icon(
                    BottomNavBar.home_2,
                    color: mainBlack,
                  ),
                  icon: Icon(
                    BottomNavBar.home_2,
                    color: mainWhite,
                  ),
                  label: 'Products',
                ),
                NavigationDestination(
                  icon: Badge.count(
                    isLabelVisible: context.getAppState().cartItems.isNotEmpty,
                    count: context.getAppState().cartItems.length,
                    child: const Icon(
                      BottomNavBar.shopping_cart,
                      color: mainWhite,
                      size: 26,
                    ),
                  ),
                  selectedIcon: Badge.count(
                    isLabelVisible: context.getAppState().cartItems.isNotEmpty,
                    count: context.getAppState().cartItems.length,
                    textColor: Colors.white,
                    child: const Icon(
                      BottomNavBar.shopping_cart,
                      color: mainBlack,
                      size: 26,
                    ),
                  ),
                  label: 'My Cart',
                ),
                const NavigationDestination(
                  selectedIcon: Icon(
                    BottomNavBar.group_2238,
                    color: mainBlack,
                    size: 30,
                  ),
                  icon: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      BottomNavBar.group_2238,
                      color: mainWhite,
                      size: 30,
                    ),
                  ),
                  label: 'Products',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onChangeDestination(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    _currentIndex = index;
    log('Called');
    setState(() {});
  }

  void onSwipePage(int index) {
    _currentIndex = index;
    setState(() {});
  }
}
