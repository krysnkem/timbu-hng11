import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_bag_app/screens/widgets/shop_with_red_bg.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.asset,
    required this.quantity,
    required this.itemTitle,
    this.onAddToCart,
    this.onRemoveFromCart,
    this.onDeleteFromCart,
    required this.price,
  });

  final String asset;
  final String quantity;
  final String itemTitle;
  final String price;
  final Function()? onAddToCart;
  final Function()? onRemoveFromCart;
  final Function()? onDeleteFromCart;

  @override
  Widget build(BuildContext context) {
    final key = itemTitle;

    String decoded = utf8.decode(key.runes.toList());
    // Normalize the string to remove any non-standard characters
    String normalized = decoded.replaceAll(RegExp(r'[\uFFFD]'), '');
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
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              normalized,
                              style: black16600,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: onDeleteFromCart,
                            child: Image.asset(
                              'assets/images/trash.png',
                              width: 20,
                            ),
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
    );
  }
}
