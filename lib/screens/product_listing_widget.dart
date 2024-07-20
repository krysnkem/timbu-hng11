import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_bag_app/screens/widgets/category_page_items.dart';
import 'package:shop_bag_app/screens/widgets/height8.dart';
import 'package:shop_bag_app/state/app_state_notifier.dart';
import 'package:shop_bag_app/utils/extensions.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

class ProductListingWidget extends StatefulWidget {
  const ProductListingWidget({
    super.key,
  });

  @override
  State<ProductListingWidget> createState() => _ProductListingWidgetState();
}

class _ProductListingWidgetState extends State<ProductListingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _controller.forward();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
              ),
              child: Stack(
                children: [
                  Image.asset('assets/images/Big Image Card (1).png'),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Premium Sound, \nPremium Savings",
                            style: white20600,
                          ),
                          const Height8(),
                          Text(
                            "Limited offer, hope on and get yours now",
                            style: white12500,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 44,
            ),
            Builder(builder: (context) {
              final shopingList = context.allProducts;

              if (shopingList.isEmpty) {
                return RefreshIndicator(
                  onRefresh: () async =>
                      (context).read<AppStateNotifier>().initializeProducts(),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height / 3,
                      ),
                      Center(
                        child: Text(
                          'No products available',
                          style: black24500,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () async =>
                    (context).read<AppStateNotifier>().initializeProducts(),
                child: ListView.builder(
                  itemCount: context.productsToCategoryMapping.keys.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Builder(builder: (context) {
                      final key = context.productsToCategoryMapping.keys
                          .toList()[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 60.0),
                        child: CategoryPageItems(
                          categoryItems:
                              context.productsToCategoryMapping[key]!,
                          categoryName: key,
                        ),
                      );
                    });
                  },
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
