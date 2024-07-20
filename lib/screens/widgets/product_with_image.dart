import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_bag_app/data/model/product/product.dart';
import 'package:shop_bag_app/screens/widgets/height4.dart';
import 'package:shop_bag_app/screens/widgets/height8.dart';
import 'package:shop_bag_app/screens/widgets/product_widget.dart';
import 'package:shop_bag_app/state/app_state_notifier.dart';
import 'package:shop_bag_app/state/favouties_state_notifier.dart';
import 'package:shop_bag_app/utils/colors.dart';
import 'package:shop_bag_app/utils/extensions.dart';

class ProductWithImage extends StatelessWidget {
  const ProductWithImage({
    super.key,
    required this.product,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return SizedBox(
        width: 150,
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: CachedNetworkImage(
                key: ValueKey(product.imageUrl),
                imageUrl: product.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: imageGrey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const Height8(),
            const Height4(),
            ProductWidget(
              itemName: product.name,
              itemDescription: product.description,
              price: '${product.price.toInt()}'.formattedAmount,
              onAddToCart: () {
                context.read<AppStateNotifier>().addToCart(product);
              },
              rating: int.parse(product.rating),
              removeFromCart: () {
                context.read<AppStateNotifier>().deleteFromCart(product);
              },
              isInCart: context.cartItems.any(
                (element) => element.product == product,
              ),
              addToFavourite: () {
                context.read<FavoritesStateNotifier>().addToFavorites(product);
              },
              isFavourite: context.allFavourites.contains(product),
              removeFromFavourite: () {
                context
                    .read<FavoritesStateNotifier>()
                    .removeFromFavorites(product);
              },
            ),
          ],
        ),
      );
    });
  }
}
