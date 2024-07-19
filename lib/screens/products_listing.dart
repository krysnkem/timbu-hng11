import 'package:flutter/material.dart';
import 'package:shop_bag_app/screens/home_flow.dart';
import 'package:shop_bag_app/state/app_state_model.dart';
import 'package:shop_bag_app/state/app_state_widget.dart';
import 'package:shop_bag_app/utils/colors.dart';
import 'package:shop_bag_app/utils/extensions.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

import 'widgets/category_page_items.dart';
import 'widgets/favorite_list_icon.dart';
import 'widgets/height8.dart';
import 'widgets/malltiverse_top_bar_icon.dart';
import 'widgets/my_app_bar.dart';

class ProductsListing extends StatefulWidget {
  const ProductsListing({super.key});

  @override
  State<ProductsListing> createState() => _ProductsListingState();
}

class _ProductsListingState extends State<ProductsListing>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    AppStateModel.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        leading: const MalltiverseTopBarIcon(),
        title: Text(
          'Product List',
          style: black19600,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(wishListOrFavourites);
            },
            icon: const FavoriteListIcon(
              color: mainBlack,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.history_rounded,
              color: mainBlack,
              size: 20,
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
                  AppStateWidget.of(context).initializeData(),
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
                  AppStateWidget.of(context).initializeData(),
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 3,
                  ),
                  const Center(child: CircularProgressIndicator())
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24.0,
                    right: 24.0,
                  ),
                  child: Stack(
                    children: [
                      Image.asset('assets/images/Big Image Card (1).png'),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(26.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Premium Sound, \nPremium Savings",
                                style: white20600,
                              ),
                              const Height8(),
                              Text(
                                "Limited offer, hope on and get yours now",
                                style: white12500,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 44,
                ),
                Builder(builder: (context) {
                  final shopingList = context.allProducts;

                  if (shopingList.isEmpty) {
                    return RefreshIndicator(
                      onRefresh: () async =>
                          AppStateWidget.of(context).initializeData(),
                      child: ListView(
                        children: [
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height / 3,
                          ),
                          Center(
                            child: Text(
                              'No products available',
                              style: black24500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () async =>
                        AppStateWidget.of(context).initializeData(),
                    child: ListView.builder(
                      itemCount: context.productsToCategoryMapping.keys.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final key = context.productsToCategoryMapping.keys
                            .toList()[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 60.0),
                          child: CategoryPageItems(
                            categoryItems:
                                context.productsToCategoryMapping[key]!,
                            categoryName: key,
                          ),
                        );
                      },
                    ),
                  );
                })
              ],
            ),
          );
        }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
