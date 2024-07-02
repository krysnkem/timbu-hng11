import 'package:flutter/material.dart';
import 'package:shop_bag_app/data/model.dart/product.dart';
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
  late List<Product> shopingList;

  @override
  void initState() {
    shopingList = AppStateScope.read(context).allProducts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
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
            return ListView.builder(
              itemCount: shopingList.length,
              itemBuilder: (context, index) {
                final data = shopingList[index];
                var localAsset = data.image;
                final brand = data.brand;
                final itemTitle = data.name;
                final availableColors = data.color;
                final size = data.size;

                return ProductItem(
                  localAsset: localAsset,
                  brand: brand,
                  itemTitle: itemTitle,
                  availableColors: availableColors,
                  size: size,
                  onAddToCart: () {
                    AppStateWidget.of(context).addToCart(data);
                  },
                  price: '${data.price}',
                );
              },
            );
          }),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
