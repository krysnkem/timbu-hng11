import 'package:flutter/material.dart';

class MalltiverseIconWidget extends StatelessWidget {
  const MalltiverseIconWidget({
    super.key,
    this.width = 80,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Image.asset(
        'assets/images/Malltiverse Logo.png',
        width: width,
      ),
    );
  }
}
