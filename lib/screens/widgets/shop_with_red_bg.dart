import 'package:flutter/material.dart';
import 'package:shop_bag_app/utils/colors.dart';

class ShopWithRedBg extends StatelessWidget {
  const ShopWithRedBg({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shape: const CircleBorder(),
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: appPrimaryColor,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.shopping_bag,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }
}
