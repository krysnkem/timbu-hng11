import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_bag_app/screens/order_detail.dart';
import 'package:shop_bag_app/screens/widgets/app_circular_progress_indicator.dart';
import 'package:shop_bag_app/screens/widgets/product_with_image.dart';
import 'package:shop_bag_app/state/favouties_state_notifier.dart';
import 'package:shop_bag_app/utils/extensions.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StandardAppBar(
        title: 'Wishlist',
      ),
      body: Builder(
        builder: (context) {
          if (context.isLoadingCartItems) {
            return RefreshIndicator(
              onRefresh: () async =>
                  (context).read<FavoritesStateNotifier>().loadAllFavourites(),
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 3,
                  ),
                  const Center(child: AppCircularProgressIndicator())
                ],
              ),
            );
          }
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
            child: RefreshIndicator(
              onRefresh: () async =>
                  (context).read<FavoritesStateNotifier>().loadAllFavourites(),
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
            ),
          );
        },
      ),
    );
  }
}
