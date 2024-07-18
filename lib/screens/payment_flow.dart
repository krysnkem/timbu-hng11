import 'package:flutter/material.dart';
import 'package:shop_bag_app/screens/checkout_page.dart';
import 'package:shop_bag_app/screens/order_successful.dart';
import 'package:shop_bag_app/screens/payment_page.dart';

class PaymentFlow extends StatelessWidget {
  const PaymentFlow({super.key, required this.onCompletePayment});

  final VoidCallback onCompletePayment;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: checkout,
      onGenerateRoute: (settings) {
        WidgetBuilder builder;

        if (settings.name == paymentSuccessful) {
          builder = (context) => OrderSuccessfulScreen(
                onCompletePayment: onCompletePayment,
              );
        }
        builder = nestedRouteBuiilders[settings.name!]!;

        return MaterialPageRoute(
          builder: builder,
          settings: settings,
        );
      },
    );
  }
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
