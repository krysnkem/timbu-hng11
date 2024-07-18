import 'package:flutter/material.dart';
import 'package:shop_bag_app/utils/colors.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

class TitleandAmount extends StatelessWidget {
  const TitleandAmount({
    super.key,
    required this.name,
    required this.value,
    this.prefix,
  });

  final String name;
  final String value;
  final String? prefix;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: black12500.copyWith(
            color: mainBlack.withOpacity(0.8),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (prefix != null)
              Text(
                prefix!,
                style: black12A80600,
              ),
            const SizedBox(
              width: 5,
            ),
            Text(
              '₦ $value',
              style: black12A80600,
            ),
          ],
        ),
      ],
    );
  }
}
