import 'package:flutter/material.dart';
import 'package:shop_bag_app/screens/widgets/favourite_widget_outlined.dart';
import 'package:shop_bag_app/utils/colors.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

import 'favourite_icon_filled.dart';
import 'height4.dart';
import 'height8.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.itemName,
    required this.itemDescription,
    required this.price,
    required this.onAddToCart,
    required this.rating,
    required this.isInCart,
    required this.removeFromCart,
    this.isFavourite = false,
    required this.addToFavourite,
    required this.removeFromFavourite,
  });

  final String itemName;
  final String itemDescription;
  final String price;
  final VoidCallback onAddToCart;
  final VoidCallback removeFromCart;
  final VoidCallback addToFavourite;
  final VoidCallback removeFromFavourite;
  final int rating;
  final bool isInCart;
  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          itemName,
          style: black12600,
          maxLines: 1,
        ),
        const Height4(),
        Text(
          itemDescription,
          style: black12400,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const Height4(),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ...List.generate(
                        rating,
                        (index) => const Icon(
                          Icons.star,
                          color: starGold,
                          size: 16,
                        ),
                      ),
                      ...List.generate(
                        5 - rating,
                        (index) => const Icon(
                          Icons.star_border,
                          color: starGold,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                  const Height8(),
                  Text(
                    'N $price',
                    style: accent13500,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: isFavourite ? removeFromFavourite : addToFavourite,
              icon: isFavourite
                  ? const FavouriteIconWidgetFilled()
                  : const FavouriteIconWidgetOutlined(),
            )
          ],
        ),
        const Height8(),
        const Height4(),
        Material(
          color: Colors.transparent,
          child: InkWell(
            customBorder: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onTap: isInCart ? removeFromCart : onAddToCart,
            child: Ink(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: accentColor),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                isInCart ? 'Remove from Cart' : 'Add to Cart',
                style: black12500,
              ),
            ),
          ),
        )
      ],
    );
  }
}
