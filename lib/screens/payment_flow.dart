import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shop_bag_app/screens/checkout_page.dart';
import 'package:shop_bag_app/screens/order_successful.dart';
import 'package:shop_bag_app/screens/payment_page.dart';

class PaymentFlow extends StatefulWidget {
  const PaymentFlow({super.key, required this.onCompletePayment});

  final VoidCallback onCompletePayment;

  @override
  State<PaymentFlow> createState() => _PaymentFlowState();
}

final paymentFlowKey = GlobalKey<NavigatorState>();

class _PaymentFlowState extends State<PaymentFlow>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Navigator(
      key: paymentFlowKey,
      initialRoute: checkout,
      onGenerateRoute: (settings) {
        WidgetBuilder builder;

        log('${settings.name}');

        if (settings.name!.contains(paymentSuccessful)) {
          builder = (context) => OrderSuccessfulScreen(
                onCompletePayment: widget.onCompletePayment,
              );
        } else {
          builder = nestedRouteBuiilders[settings.name!]!;
        }

        return MaterialPageRoute(
          builder: builder,
          settings: settings,
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

final nestedRouteBuiilders = {
  checkout: (
    BuildContext context,
  ) =>
      const CheckoutPage(),
  paymentPage: (
    BuildContext context,
  ) =>
      const PaymentPage(),
};

const checkout = 'payment-flow/check-out';
const paymentPage = 'payment-flow/payment-page';
const paymentSuccessful = 'payment-flow/payment-successful';
