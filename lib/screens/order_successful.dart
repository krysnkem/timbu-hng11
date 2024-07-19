import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_bag_app/screens/payment_flow.dart';
import 'package:shop_bag_app/state/app_state_notifier.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

import 'widgets/primary_button.dart';

class OrderSuccessfulScreen extends StatelessWidget {
  const OrderSuccessfulScreen({super.key, required this.onCompletePayment});

  final VoidCallback onCompletePayment;

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
                  Image.asset('assets/images/all_good.png'),
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
                    style: black18400,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 3,
              ),
              PrimaryButton(
                label: 'CONTINUE SHOPPING',
                onPressed: () {
                  context.read<AppStateNotifier>().emptyCart();

                  Navigator.of(context).popUntil(
                    (route) => route.settings.name == checkout,
                  );
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
