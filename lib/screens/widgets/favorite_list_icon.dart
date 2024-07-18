import 'package:flutter/material.dart';

class FavoriteListIcon extends StatelessWidget {
  const FavoriteListIcon({
    super.key,
    this.onTap,
    required this.color,
  });
  final VoidCallback? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 24,
        width: 24,
        child: Stack(
          children: [
            Icon(
              Icons.list_alt,
              color: color,
              size: 20,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                Icons.favorite,
                color: color,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
