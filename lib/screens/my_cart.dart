import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_bag_app/data/model.dart/pre_order.dart';
import 'package:shop_bag_app/screens/widgets/malltiverse_icon_widget.dart';
import 'package:shop_bag_app/state/app_state_notifier.dart';
import 'package:shop_bag_app/utils/colors.dart';
import 'package:shop_bag_app/utils/extensions.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

import 'widgets/cart_item_widget.dart';
import 'widgets/my_app_bar.dart';
import 'widgets/primary_button.dart';
import 'widgets/shopping_summary_bottom_sheet.dart';
import 'widgets/title_and_amount.dart';

class MyCart extends StatefulWidget {
  const MyCart(
      {super.key, required this.showProductListing, required this.gotCheckOut});

  final Function() showProductListing;
  final Function() gotCheckOut;

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> with AutomaticKeepAliveClientMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      appBar: MyAppBar(
        title: Text(
          'My Cart',
          style: black19600,
        ),
        leading: const MalltiverseIconWidget(),
      ),
      body: ColoredBox(
        color: mainWhite,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                child: Builder(builder: (context) {
                  final cartList = context.cartItems;
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
                        onAddToCart: () => (context)
                            .read<AppStateNotifier>()
                            .addToCart(data.product),
                        onDeleteFromCart: () => (context)
                            .read<AppStateNotifier>()
                            .deleteFromCart(data.product),
                        onRemoveFromCart: () => (context)
                            .read<AppStateNotifier>()
                            .removeFromCart(data.product),
                        price: '${data.product.price}',
                        description: data.product.description,
                      );
                    },
                  );
                }),
              ),
              Visibility(
                visible: context.cartItems.isNotEmpty,
                child: Column(
                  children: [
                    Builder(
                      builder: (context) {
                        var name = 'Total Amount';
                        var value = getTotalCost(context)
                            .toInt()
                            .toString()
                            .formattedAmount;
                        return TitleandAmount(
                          name: name,
                          value: value,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    PrimaryButton(
                      onPressed: () async {
                        showModalBottomSheet<OrderSummary?>(
                          context: context,
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          builder: (BuildContext context) => SizedBox(
                            width: MediaQuery.sizeOf(context).width - 48,
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.viewInsetsOf(context)
                                        .bottom +
                                    (MediaQuery.sizeOf(context).height / 20),
                              ),
                              child: ShoppingSummaryBottomSheet(
                                widget: widget,
                                allProductPrice: getTotalCost(context),
                              ),
                            ),
                          ),
                        ).then(
                          (value) {
                            if (value != null) {
                              context.read<AppStateNotifier>().setPreOrder(
                                    PreOrder(
                                      subTotal: value.subTotal,
                                      deliveryFee: value.deliveryFee,
                                      discountAmount: value.discount,
                                      totalAmount: value.totalAmount,
                                      discountCode: value.discountCode,
                                      items: context
                                          .read<AppStateNotifier>()
                                          .appState
                                          .cartItems,
                                      discountPercent: value.discountPercent,
                                    ),
                                  );
                              widget.gotCheckOut();
                            }
                          },
                        );
                      },
                      label: 'CHECK OUT',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 26,
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
    return context.cartItems.fold(
      0,
      (previousValue, element) {
        return previousValue + (element.product.price * element.quantity);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
