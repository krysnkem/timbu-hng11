import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shop_bag_app/screens/favourites.dart';
import 'package:shop_bag_app/screens/orders_history.dart';
import 'package:shop_bag_app/screens/products_listing.dart';

class HomeFlow extends StatefulWidget {
  const HomeFlow({
    super.key,
  });

  @override
  State<HomeFlow> createState() => _HomeFlowState();
}

final homeFlowNavKey = GlobalKey<NavigatorState>();

class _HomeFlowState extends State<HomeFlow>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Navigator(
      key: homeFlowNavKey,
      initialRoute: productListing,
      onGenerateRoute: (settings) {
        WidgetBuilder builder;

        log('${settings.name}');

        builder = nestedRouteBuiilders[settings.name!]!;

        return MaterialPageRoute(
          builder: builder,
          settings: settings,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

final nestedRouteBuiilders = {
  productListing: (
    BuildContext context,
  ) =>
      const ProductsListing(),
  ordersHistory: (
    BuildContext context,
  ) =>
      const OrdersHistory(),
  wishListOrFavourites: (context) => const Favourites(),
};

const productListing = 'home/product-listing';
const ordersHistory = 'home/orders-history';
const wishListOrFavourites = 'home/wishlist-or-favourites';
