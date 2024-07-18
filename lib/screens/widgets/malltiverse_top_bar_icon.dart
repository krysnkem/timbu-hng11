import 'package:flutter/material.dart';

class MalltiverseTopBarIcon extends StatelessWidget {
  const MalltiverseTopBarIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Image.asset(
        'assets/images/Malltiverse Logo.png',
        width: 80,
      ),
    );
  }
}
