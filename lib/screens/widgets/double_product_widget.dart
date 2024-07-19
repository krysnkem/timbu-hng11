import 'package:flutter/material.dart';
import 'package:shop_bag_app/data/model.dart/product.dart';

import 'product_with_image.dart';

class DoubleProductWidget extends StatelessWidget {
  const DoubleProductWidget({
    super.key,
    required this.products,
  });

  final List<Product> products;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...products
            .map<Widget>(
              (product) => ProductWithImage(
                product: product,
              ),
            )
            .toList(),
      ],
    );
  }
}
