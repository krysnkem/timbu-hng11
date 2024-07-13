import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_bag_app/data/model.dart/product.dart';
import 'package:shop_bag_app/screens/widgets/height4.dart';
import 'package:shop_bag_app/screens/widgets/height8.dart';
import 'package:shop_bag_app/screens/widgets/product_widget.dart';
import 'package:shop_bag_app/state/app_state.dart';

class DoubleProductWidget extends StatelessWidget {
  const DoubleProductWidget({
    super.key,
    required this.product1,
    required this.product2,
  });

  final Product product1;
  final Product product2;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 150,
          child: Column(
            children: [
              CachedNetworkImage(
                key: ValueKey(product1.imageUrl),
                imageUrl: product1.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: SizedBox(
                    height: 150,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
              const Height8(),
              const Height4(),
              Builder(builder: (context) {
                return ProductWidget(
                  itemName: product1.name,
                  itemDescription: product1.description,
                  price: '${product1.price}',
                  onAddToCart: () {
                    AppStateWidget.of(context).addToCart(product1);
                  },
                  rating: int.parse(product1.rating),
                );
              })
            ],
          ),
        ),
        SizedBox(
          width: 150,
          child: Column(
            children: [
              CachedNetworkImage(
                key: ValueKey(product2.imageUrl),
                imageUrl: product2.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: SizedBox(
                    height: 150,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
              const Height8(),
              const Height4(),
              Builder(builder: (context) {
                return ProductWidget(
                  itemName: product2.name,
                  itemDescription: product2.description,
                  price: '${product2.price}',
                  onAddToCart: () {
                    AppStateWidget.of(context).addToCart(product2);
                  },
                  rating: int.parse(product2.rating),
                );
              })
            ],
          ),
        ),
      ],
    );
  }
}
