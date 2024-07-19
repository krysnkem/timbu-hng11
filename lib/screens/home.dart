import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:shop_bag_app/screens/home_flow.dart';
import 'package:shop_bag_app/screens/my_cart.dart';
import 'package:shop_bag_app/screens/payment_flow.dart';
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
  bool _isAnimating = false;

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    if (_currentIndex != 2 && _currentIndex != 0) {
      return false;
    }
    if (_currentIndex == 0 && homeFlowNavKey.currentState!.canPop()) {
      homeFlowNavKey.currentState!.pop();
      return true;
    }
    if (_currentIndex == 2 && paymentFlowNavKey.currentState!.canPop()) {
      paymentFlowNavKey.currentState!.pop();
      return true;
    }

    return false;
  }

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor,
        name: widget.toString(), context: context);

    precacheImage(const AssetImage('assets/images/Card.png'), context);
  }

  @override
  void dispose() {
    _pageController.dispose();
    BackButtonInterceptor.remove(myInterceptor);

    super.dispose();
  }

  void onChangeDestination(int index) {
    if (_currentIndex != index && !_isAnimating) {
      setState(() {
        _currentIndex = index;
        _isAnimating = true;
      });
      _pageController
          .animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      )
          .then((_) {
        setState(() {
          _isAnimating = false;
        });
      });
    }
  }

  void onSwipePage(int index) {
    if (!_isAnimating) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: onSwipePage,
        children: [
          const HomeFlow(),
          MyCart(
            showProductListing: () {
              onChangeDestination(0);
            },
            gotCheckOut: () {
              onChangeDestination(2);
            },
          ),
          PaymentFlow(
            onCompletePayment: () {
              onChangeDestination(0);
            },
          ),
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
                      BottomNavBar.shopping_cart_2,
                      color: mainWhite,
                    ),
                  ),
                  selectedIcon: Badge.count(
                    isLabelVisible: context.getAppState().cartItems.isNotEmpty,
                    count: context.getAppState().cartItems.length,
                    textColor: Colors.white,
                    child: const Icon(
                      BottomNavBar.shopping_cart_2,
                      color: mainBlack,
                    ),
                  ),
                  label: 'My Cart',
                ),
                const NavigationDestination(
                  selectedIcon: Icon(
                    BottomNavBar.shop_cart_arrow,
                    color: mainBlack,
                    size: 30,
                  ),
                  icon: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      BottomNavBar.shop_cart_arrow,
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
}
