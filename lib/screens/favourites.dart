import 'package:flutter/material.dart';
import 'package:shop_bag_app/screens/order_detail.dart';
import 'package:shop_bag_app/screens/widgets/product_with_image.dart';
import 'package:shop_bag_app/utils/extensions.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StandardAppBar(
        title: 'Wishlist',
      ),
      body: Builder(
        builder: (context) {
          if (context.allFavourites.isEmpty) {
            return Center(
              child: Text(
                'Favourites will show here',
                style: black24500,
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: GridView.builder(
              itemCount: context.allFavourites.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 9 / 16, crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Builder(
                  builder: (context) {
                    return Center(
                      child: ProductWithImage(
                        product: context.allFavourites[index],
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
