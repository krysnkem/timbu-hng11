import 'package:flutter/material.dart';
import 'package:shop_bag_app/screens/widgets/shop_with_red_bg.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.localAsset,
    required this.brand,
    required this.itemTitle,
    required this.availableColors,
    required this.size,
    this.onAddToCart,
    required this.price,
  });

  final String localAsset;
  final String brand;
  final String itemTitle;
  final String availableColors;
  final String size;
  final String price;
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
                          Row(
                            children: [
                              Text(
                                '₦$price',
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
