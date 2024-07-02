import 'package:flutter/material.dart';
import 'package:shop_bag_app/screens/my_cart.dart';
import 'package:shop_bag_app/state/app_state.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

class OrderSuccessfulScreen extends StatelessWidget {
  const OrderSuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/bags.png'),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Success!',
                    style: black34Bold,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'Your order will be delivered soon.Thank you for choosing our app!',
                    textAlign: TextAlign.center,
                    style: black14400,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 3,
              ),
              PrimaryButton(
                label: 'CONTINUE SHOPPING',
                onPressed: () {
                  AppStateWidget.of(context).emptyCart();
                  
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(
                height: 36,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
