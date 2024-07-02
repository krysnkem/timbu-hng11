import 'package:flutter/material.dart';
import 'package:shop_bag_app/screens/products_listing.dart';
import 'package:shop_bag_app/state/app_state.dart';
import 'package:shop_bag_app/utils/colors.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

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
                  onDeleteFromCart: () =>
                      AppStateWidget.of(context).deleteFromCart(data.product),
                  onRemoveFromCart: () =>
                      AppStateWidget.of(context).removeFromCart(data.product),
                );
              },
            );
          }),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
