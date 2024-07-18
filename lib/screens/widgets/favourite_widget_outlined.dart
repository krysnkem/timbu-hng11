import 'package:flutter/material.dart';
import 'package:shop_bag_app/utils/colors.dart';

class FavouriteIconWidgetOutlined extends StatelessWidget {
  const FavouriteIconWidgetOutlined({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.favorite_outline_rounded,
      color: accentColor,
    );
  }
}
