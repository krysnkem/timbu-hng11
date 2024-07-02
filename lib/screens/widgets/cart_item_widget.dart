import 'package:flutter/material.dart';
import 'package:shop_bag_app/screens/widgets/shop_with_red_bg.dart';
import 'package:shop_bag_app/utils/colors.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

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
    required this.price,
  });

  final String localAsset;
  final String quantity;
  final String itemTitle;
  final String availableColors;
  final String size;
  final String price;
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
                          InkWell(
                            onTap: onDeleteFromCart,
                            child: const Icon(
                              Icons.close,
                              color: textGrey,
                            ),
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
