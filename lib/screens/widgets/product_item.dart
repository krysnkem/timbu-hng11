import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_bag_app/screens/widgets/shop_with_red_bg.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.asset,
    required this.itemTitle,
    this.onAddToCart,
    required this.price,
    required this.description,
    this.onTap,
  });

  final String asset;
  final String itemTitle;
  final String price;
  final String description;
  final Function()? onAddToCart;
  final Function()? onTap;

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
            child: Material(
              child: InkWell(
                onTap: onTap,
                child: Ink(
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
                              child: Builder(builder: (context) {
                                if (!asset.startsWith('http')) {
                                  return Image.asset(
                                    key: ValueKey(asset),
                                    'assets/images/$asset',
                                    fit: BoxFit.cover,
                                  );
                                } else {
                                  return CachedNetworkImage(
                                    key: ValueKey(asset),
                                    imageUrl: asset,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                              }),
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
                                  itemTitle,
                                  style: black16600,
                                ),
                                Text(
                                  description,
                                  style: grey11400,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
