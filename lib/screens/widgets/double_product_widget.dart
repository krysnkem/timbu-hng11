import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_bag_app/data/model.dart/product.dart';
import 'package:shop_bag_app/screens/widgets/height4.dart';
import 'package:shop_bag_app/screens/widgets/height8.dart';
import 'package:shop_bag_app/screens/widgets/product_widget.dart';
import 'package:shop_bag_app/state/app_state.dart';
import 'package:shop_bag_app/utils/colors.dart';
import 'package:shop_bag_app/utils/extensions.dart';

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
