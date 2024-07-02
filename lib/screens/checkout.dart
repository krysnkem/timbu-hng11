import 'package:flutter/material.dart';
import 'package:shop_bag_app/state/app_state.dart';
import 'package:shop_bag_app/utils/colors.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

import 'widgets/cart_item_widget.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'My Cart',
          style: pageTitleStyle,
        ),
      ),
      body: ColoredBox(
        color: backgroundGrey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                child: Builder(builder: (context) {
                  final cartList = AppStateScope.of(context).cartItems;
                  if (cartList.isEmpty) {
                    return const Center(
                      child: Text('Cart items will show here'),
                    );
                  }
                  return ListView.builder(
                    itemCount: cartList.length,
                    itemBuilder: (context, index) {
                      final data = cartList[index];
                      var localAsset = data.product.image;
                      final itemTitle = data.product.name;
                      final availableColors = data.product.color;
                      final size = data.product.size;

                      return CartItemWidget(
                        localAsset: localAsset,
                        quantity: '${data.quantity}',
                        itemTitle: itemTitle,
                        availableColors: availableColors,
                        size: size,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Amount',
                      style: grey14400,
                    ),
                    Text(
                      '₦${getTotalCost(context)}',
                      style: black18600,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              Visibility(
                visible: AppStateScope.of(context).cartItems.isNotEmpty,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appPrimaryColor,
                        ),
                        onPressed: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'CHECK OUT',
                            style: white14300,
                          ),
                        ),
                      ),
                    ),
                  ],
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
