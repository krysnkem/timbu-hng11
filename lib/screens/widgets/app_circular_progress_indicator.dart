import 'package:flutter/material.dart';
import 'package:shop_bag_app/utils/colors.dart';

class AppCircularProgressIndicator extends StatelessWidget {
  const AppCircularProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: accentColor,
    );
  }
}
