import 'package:flutter/material.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wishlist',
          style: black19600,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
