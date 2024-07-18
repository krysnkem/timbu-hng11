import 'package:flutter/material.dart';
import 'package:shop_bag_app/screens/order_successful.dart';
import 'package:shop_bag_app/screens/widgets/malltiverse_top_bar_icon.dart';
import 'package:shop_bag_app/state/app_state.dart';
import 'package:shop_bag_app/utils/colors.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

import 'widgets/cart_item_widget.dart';
import 'widgets/my_app_bar.dart';
import 'widgets/primary_button.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key, required this.showProductListing});

  final Function() showProductListing;

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: MyAppBar(
        title: Text(
          'My Cart',
          style: black19600,
        ),
        leading: const MalltiverseTopBarIcon(),
      ),
      body: ColoredBox(
        color: mainWhite,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                child: Builder(builder: (context) {
                  final cartList = AppStateScope.of(context).cartItems;
                  if (cartList.isEmpty) {
                    return Center(
                      child: Text(
                        'No Item in Cart',
                        style: black24500,
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: cartList.length,
                    itemBuilder: (context, index) {
                      final data = cartList[index];
                      var localAsset = data.product.imageUrl;
                      final itemTitle = data.product.name;

                      return CartItemWidget(
                        asset: localAsset,
                        quantity: '${data.quantity}',
                        itemTitle: itemTitle,
                        onAddToCart: () =>
                            AppStateWidget.of(context).addToCart(data.product),
                        onDeleteFromCart: () => AppStateWidget.of(context)
                            .deleteFromCart(data.product),
                        onRemoveFromCart: () => AppStateWidget.of(context)
                            .removeFromCart(data.product),
                        price: '${data.product.price}',
                      );
                    },
                  );
                }),
              ),
              Visibility(
                visible: AppStateScope.of(context).cartItems.isNotEmpty,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount',
                          style: black12500.copyWith(
                              color: mainBlack.withOpacity(0.8)),
                        ),
                        Text(
                          '₦${getTotalCost(context)}',
                          style: black18600,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              Visibility(
                visible: AppStateScope.of(context).cartItems.isNotEmpty,
                child: PrimaryButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderSuccessfulScreen(),
                      ),
                    );
                    await Future.delayed(const Duration(milliseconds: 200));
                    widget.showProductListing();
                  },
                  label: 'CHECK OUT',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  num getTotalCost(BuildContext context) {
    return AppStateScope.of(context).cartItems.fold(
      0,
      (previousValue, element) {
        return previousValue + (element.product.price * element.quantity);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
