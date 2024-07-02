import 'package:flutter/material.dart';
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
const back11400 = TextStyle(
  fontSize: 11,
  color: textBlack,
);

const black14500 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: textBlack,
);

class ProductsListing extends StatelessWidget {
  const ProductsListing({super.key});

  @override
  Widget build(BuildContext context) {



    
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
          child: ListView.builder(
            itemBuilder: (context, index) {
              var localAsset = 'casual-coprate#1.jpg';
              const brand = 'LIME';
              const itemTitle = 'Shirt';
              const availableColors = 'Blue';
              const size = 'L';

              return ProductItem(
                localAsset: localAsset,
                brand: brand,
                itemTitle: itemTitle,
                availableColors: availableColors,
                size: size,
              );
            },
          ),
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.localAsset,
    required this.brand,
    required this.itemTitle,
    required this.availableColors,
    required this.size,
  });

  final String localAsset;
  final String brand;
  final String itemTitle;
  final String availableColors;
  final String size;

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
                      child: Image.asset(
                        'assets/images/$localAsset',
                        fit: BoxFit.fill,
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
                                style: back11400,
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
                                style: back11400,
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
        const Positioned(
          right: 0,
          top: 110,
          child: ShopWithRedBg(),
        )
      ],
    );
  }
}
