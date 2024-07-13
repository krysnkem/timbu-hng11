import 'package:flutter/material.dart';
import 'package:shop_bag_app/utils/colors.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.isExpanded = true});

  final String label;
  final Function() onPressed;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isExpanded ? 36.0 : 0),
      child: SizedBox(
        width: isExpanded ? double.infinity : null,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: accentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              label,
              style: black12600,
            ),
          ),
        ),
      ),
    );
  }
}
