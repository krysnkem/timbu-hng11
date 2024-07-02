import 'package:flutter/material.dart';
import 'package:shop_bag_app/data/model.dart/product.dart';
import 'package:shop_bag_app/state/app_state.dart';
import 'package:shop_bag_app/utils/colors.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

import 'widgets/shop_with_red_bg.dart';

const grey11400 = TextStyle(
  color: textGrey,
  fontSize: 11,
);
const black16600 = TextStyle(
  color: textBlack,
  fontWeight: FontWeight.w600,
  fontSize: 16,
);
const black11400 = TextStyle(
  fontSize: 11,
  color: textBlack,
);

const black14500 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: textBlack,
);

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
                );
              },
            );
          }),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.localAsset,
    required this.brand,
    required this.itemTitle,
    required this.availableColors,
    required this.size,
    this.onAddToCart,
  });

  final String localAsset;
  final String brand;
  final String itemTitle;
  final String availableColors;
  final String size;
  final Function()? onAddToCart;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2.0, bottom: 26),
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: SizedBox(
              height: 120,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                      child: SizedBox(
                        height: double.infinity,
                        child: Image.asset(
                          key: ValueKey(localAsset),
                          'assets/images/$localAsset',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 15.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            brand,
                            style: grey11400,
                          ),
                          Text(
                            itemTitle,
                            style: black16600,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Color:',
                                style: grey11400,
                              ),
                              Text(
                                availableColors,
                                style: black11400,
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              const Text(
                                'Size:',
                                style: grey11400,
                              ),
                              Text(
                                size,
                                style: black11400,
                              ),
                            ],
                          ),
                          const Row(
                            children: [
                              Text(
                                '₦3000',
                                style: black14500,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 110,
          child: InkWell(
            onTap: onAddToCart,
            child: const ShopWithRedBg(),
          ),
        )
      ],
    );
  }
}

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.localAsset,
    required this.quantity,
    required this.itemTitle,
    required this.availableColors,
    required this.size,
    this.onAddToCart,
    this.onRemoveFromCart,
    this.onDeleteFromCart,
  });

  final String localAsset;
  final String quantity;
  final String itemTitle;
  final String availableColors;
  final String size;
  final Function()? onAddToCart;
  final Function()? onRemoveFromCart;
  final Function()? onDeleteFromCart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, bottom: 26),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: SizedBox(
          height: 120,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  child: SizedBox(
                    height: double.infinity,
                    child: Image.asset(
                      key: ValueKey(localAsset),
                      'assets/images/$localAsset',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 15.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              itemTitle,
                              style: black16600,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.close,
                            color: textGrey,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Color:',
                            style: grey11400,
                          ),
                          Text(
                            availableColors,
                            style: black11400,
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          const Text(
                            'Size:',
                            style: grey11400,
                          ),
                          Text(
                            size,
                            style: black11400,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: onRemoveFromCart,
                                child: const MinusWidget(),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(
                                quantity,
                                style: black14500,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              InkWell(
                                onTap: onAddToCart,
                                child: const AddWidget(),
                              )
                            ],
                          ),
                          const Text(
                            '₦3000',
                            style: black14500,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
