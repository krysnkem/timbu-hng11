import 'package:flutter/material.dart';
import 'package:shop_bag_app/screens/widgets/filled_dot.dart';
import 'package:shop_bag_app/screens/widgets/outine_dot.dart';

class ActiveDot extends StatelessWidget {
  const ActiveDot({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return const FilledDot();
    } else {
      return const OutineDot();
    }
  }
}
