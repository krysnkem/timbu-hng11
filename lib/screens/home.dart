import 'package:flutter/material.dart';
import 'package:shop_bag_app/screens/my_cart.dart';
import 'package:shop_bag_app/screens/products_listing.dart';
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
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: onChangeDestination,
        indicatorColor: appPrimaryColor,
        selectedIndex: _currentIndex,
        destinations: <Widget>[
          const NavigationDestination(
            selectedIcon: Icon(
              Icons.list,
              color: Colors.white,
            ),
            icon: Icon(
              Icons.list,
            ),
            label: 'Products',
          ),
          NavigationDestination(
            icon: Badge.count(
              isLabelVisible: context.getAppState().cartItems.isNotEmpty,
              count: context.getAppState().cartItems.length,
              child: const Icon(
                Icons.shopping_bag,
              ),
            ),
            selectedIcon: Badge.count(
              isLabelVisible: context.getAppState().cartItems.isNotEmpty,
              count: context.getAppState().cartItems.length,
              textColor: Colors.white,
              child: const Icon(
                Icons.shopping_bag,
                color: Colors.white,
              ),
            ),
            label: 'My Cart',
          ),
        ],
      ),
    );
  }

  void onChangeDestination(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);

    _currentIndex = index;
    setState(() {});
  }

  void onSwipePage(int index) {
    _currentIndex = index;
    setState(() {});
  }
}
