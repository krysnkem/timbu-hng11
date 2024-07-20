import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_bag_app/screens/home_flow.dart';
import 'package:shop_bag_app/screens/widgets/app_circular_progress_indicator.dart';
import 'package:shop_bag_app/state/app_state_notifier.dart';
import 'package:shop_bag_app/utils/colors.dart';
import 'package:shop_bag_app/utils/extensions.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

import 'product_listing_widget.dart';
import 'widgets/favorite_list_icon.dart';
import 'widgets/malltiverse_icon_widget.dart';
import 'widgets/my_app_bar.dart';

class ProductsListing extends StatefulWidget {
  const ProductsListing({super.key});

  @override
  State<ProductsListing> createState() => _ProductsListingState();
}

class _ProductsListingState extends State<ProductsListing>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        leading: const MalltiverseIconWidget(),
        title: Text(
          'Product List',
          style: black19600,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(wishListOrFavourites);
            },
            icon: Badge(
              isLabelVisible: context.allFavourites.isNotEmpty,
              child: const FavoriteListIcon(
                color: mainBlack,
              ),
            ),
          ),
          IconButton(
            icon: Badge(
              isLabelVisible: context.allOrders.isNotEmpty,
              child: const Icon(
                Icons.history_rounded,
                color: mainBlack,
                size: 20,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(ordersHistory);
            },
          ),
          const SizedBox(
            width: 24,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Builder(builder: (context) {
          if (!context.isLoading && context.error != null) {
            return RefreshIndicator(
              onRefresh: () async =>
                  (context).read<AppStateNotifier>().initializeData(),
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 3,
                  ),
                  Center(
                    child: Text(
                      '${context.error}',
                      style: black24500,
                    ),
                  )
                ],
              ),
            );
          }

          if (context.isLoading) {
            return RefreshIndicator(
              onRefresh: () async =>
                  (context).read<AppStateNotifier>().initializeData(),
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 3,
                  ),
                  const Center(child: AppCircularProgressIndicator())
                ],
              ),
            );
          }

          return const ProductListingWidget();
        }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
