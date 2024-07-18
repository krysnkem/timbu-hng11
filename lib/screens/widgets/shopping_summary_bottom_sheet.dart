import 'package:flutter/material.dart';
import 'package:shop_bag_app/screens/my_cart.dart';
import 'package:shop_bag_app/screens/widgets/primary_button.dart';
import 'package:shop_bag_app/screens/widgets/title_and_amount.dart';
import 'package:shop_bag_app/utils/colors.dart';
import 'package:shop_bag_app/utils/extensions.dart';
import 'package:shop_bag_app/utils/random_generator.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

class ShoppingSummaryBottomSheet extends StatefulWidget {
  const ShoppingSummaryBottomSheet({
    super.key,
    required this.widget,
    required this.allProductPrice,
  });

  final num allProductPrice;

  final MyCart widget;

  @override
  State<ShoppingSummaryBottomSheet> createState() =>
      _ShoppingSummaryBottomSheetState();
}

class _ShoppingSummaryBottomSheetState
    extends State<ShoppingSummaryBottomSheet> {
  int deliveryFee = 0;
  int discountPercent = 0;

  final TextEditingController _controller = TextEditingController();
  int discountCodeLength = 0;
  bool discountCodeApplied = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        deliveryFee = RandomGenerator.generateDeliveryFee();
      });
    });

    _controller.addListener(listenToDiscountCode);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int get undiscountedPrice {
    return widget.allProductPrice.toInt() + deliveryFee;
  }

  int get discount {
    return (undiscountedPrice * (discountPercent / 100)).toInt();
  }

  int get totalAmount {
    return undiscountedPrice - discount;
  }

  void applyDiscountCode() {
    setState(() {
      discountPercent = RandomGenerator.generateDiscountAmount();
      discountCodeApplied = true;
    });
  }

  void listenToDiscountCode() {
    setState(() {
      discountCodeLength = _controller.text.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundGrey,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Shopping Summary', style: black16600),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Text('Discount Code', style: black14A80500),
              const SizedBox(height: 8),
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
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
                    ),
                    const SizedBox(width: 36),
                    PrimaryButton(
                      label: discountCodeApplied ? 'Applied' : 'Apply',
                      onPressed: applyDiscountCode,
                      isExpanded: false,
                      enabled: [6, 7, 8].contains(discountCodeLength) &&
                          !discountCodeApplied,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              TitleandAmount(
                  name: 'Sub-Total',
                  value: '${widget.allProductPrice.toInt()}'.formattedAmount),
              const SizedBox(height: 8),
              TitleandAmount(
                name: 'Delivery Fee',
                value: '$deliveryFee'.formattedAmount,
                prefix: '+',
              ),
              const SizedBox(height: 8),
              TitleandAmount(
                name:
                    'Discount Amount ${discountPercent != 0 ? "($discountPercent%)" : ""}',
                value: '$discount',
                prefix: '-',
              ),
              const SizedBox(height: 8),
              Center(child: Image.asset('assets/images/dashed-line.png')),
              const SizedBox(height: 8),
              const SizedBox(height: 4),
              Builder(
                builder: (context) {
                  return TitleandAmount(
                    name: 'Total Amount',
                    value: "$totalAmount".formattedAmount,
                  );
                },
              ),
              const SizedBox(height: 26),
              PrimaryButton(
                onPressed: () async {
                  Navigator.of(context).pop(
                    OrderSummary(
                      subTotal: widget.allProductPrice.toInt(),
                      deliveryFee: deliveryFee,
                      discountPercent: discountPercent,
                      discount: discount,
                      totalAmount: totalAmount,
                      discountCode: _controller.text,
                    ),
                  );
                },
                label: 'CHECK OUT',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderSummary {
  final int subTotal;
  final int deliveryFee;
  final int discountPercent;
  final int discount;
  final int totalAmount;
  final String discountCode;

  OrderSummary({
    required this.subTotal,
    required this.deliveryFee,
    required this.discountPercent,
    required this.discount,
    required this.totalAmount,
    required this.discountCode,
  });
}
