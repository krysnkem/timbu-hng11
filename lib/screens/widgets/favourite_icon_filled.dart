import 'package:flutter/material.dart';
import 'package:shop_bag_app/utils/colors.dart';

class FavouriteIconWidgetFilled extends StatelessWidget {
  const FavouriteIconWidgetFilled({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.favorite_rounded,
      color: accentColor,
    );
  }
}
