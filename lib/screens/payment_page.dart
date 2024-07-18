import 'package:flutter/material.dart';
import 'package:shop_bag_app/screens/widgets/height4.dart';
import 'package:shop_bag_app/screens/widgets/height8.dart';
import 'package:shop_bag_app/screens/widgets/primary_button.dart';
import 'package:shop_bag_app/utils/colors.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment',
          style: black19600,
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 24.0,
              right: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset('assets/images/Card.png'),
                    Positioned(
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(26.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "5047 1245 7689 2345",
                              style: white20600Poppins,
                            ),
                            const Height8(),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Card holder name",
                                      style: white11400Poppins,
                                    ),
                                    Text(
                                      "Hafsat Ardo",
                                      style: white11600Poppins,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Expiry date",
                                      style: white11400Poppins,
                                    ),
                                    Text(
                                      "02/30",
                                      style: white11600Poppins,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                ...List.generate(
                  4,
                  (_) => const Height8(),
                ),
                Text(
                  'Card Number',
                  style: black14500,
                ),
                const Height8(),
                const Height4(),
                TextField(
                  decoration: InputDecoration(
                    hintText: '0000 0000 0000 0000',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: mainBlack.withOpacity(0.5),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                ),
                ...List.generate(
                  4,
                  (_) => const Height8(),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Expiry Date',
                            style: black14500,
                          ),
                          const Height8(),
                          const Height4(),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'MM/YY',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: mainBlack.withOpacity(0.5),
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CVV',
                            style: black14500,
                          ),
                          const Height8(),
                          const Height4(),
                          TextField(
                            decoration: InputDecoration(
                              hintText: '123',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: mainBlack.withOpacity(0.5),
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ...List.generate(
                  4,
                  (_) => const Height8(),
                ),
                PrimaryButton(
                  label: 'Make Payment',
                  onPressed: () {},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
