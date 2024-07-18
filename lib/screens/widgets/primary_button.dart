import 'package:flutter/material.dart';
import 'package:shop_bag_app/utils/colors.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.isExpanded = true,
      this.enabled = true});

  final String label;
  final Function() onPressed;
  final bool isExpanded;
  final bool enabled;

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
          onPressed: enabled ? onPressed : null,
          child: Padding(
            padding: EdgeInsets.all(isExpanded ? 16.0 : 0),
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
