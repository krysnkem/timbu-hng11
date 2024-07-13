import 'package:flutter/material.dart';
import 'package:shop_bag_app/utils/colors.dart';

class OutineDot extends StatelessWidget {
  const OutineDot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: accentColor),
      ),
    );
  }
}
