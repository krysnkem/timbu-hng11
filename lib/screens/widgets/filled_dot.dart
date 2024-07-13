import 'package:flutter/material.dart';
import 'package:shop_bag_app/utils/colors.dart';

class FilledDot extends StatelessWidget {
  const FilledDot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: accentColor,
      ),
    );
  }
}
