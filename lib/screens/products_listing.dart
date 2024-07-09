import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shop_bag_app/screens/product_detail_screen.dart';
import 'package:shop_bag_app/state/app_state.dart';
import 'package:shop_bag_app/utils/colors.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

import 'widgets/product_item.dart';

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
    return Scaffold(
      backgroundColor: backgroundGrey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Products',
          style: pageTitleStyle,
        ),
      ),
      body: ColoredBox(
        color: backgroundGrey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Builder(builder: (context) {
            final appState = AppStateScope.of(context);

            if (!appState.isLoading && appState.error != null) {
              return RefreshIndicator(
                onRefresh: () async =>
                    AppStateWidget.of(context).initializeData(),
                child: ListView(
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height / 3,
                    ),
                    Center(
                      child: Text('${appState.error}'),
                    )
                  ],
                ),
              );
            }

            if (appState.isLoading) {
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

            final shopingList = appState.allProducts;

            if (shopingList.isEmpty) {
              return RefreshIndicator(
                onRefresh: () async =>
                    AppStateWidget.of(context).initializeData(),
                child: ListView(
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height / 3,
                    ),
                    const Center(
                      child: Text('No products available'),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async =>
                  AppStateWidget.of(context).initializeData(),
              child: ListView.builder(
                itemCount: shopingList.length,
                itemBuilder: (context, index) {
                  final data = shopingList[index];

                  return ProductItem(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            productId: data.id,
                          ),
                        ),
                      );
                    },
                    asset: data.image,
                    itemTitle: data.name,
                    description: data.description,
                    onAddToCart: () {
                      AppStateWidget.of(context).addToCart(data);
                    },
                    price: '${data.price}',
                  );
                },
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
