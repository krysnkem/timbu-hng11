import 'package:flutter/material.dart';
import 'package:shop_bag_app/screens/products_listing.dart';
import 'package:shop_bag_app/screens/widgets/primary_button.dart';
import 'package:shop_bag_app/utils/colors.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool _option = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        title: Text(
          'Checkout',
          style: black19600,
        ),
        leading: Image.asset(
          'assets/images/Malltiverse Logo.png',
          width: 100,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Height8(),
              const Height8(),
              const Height8(),
              Text(
                'Select how to receive your package(s)',
                style: black14500,
              ),
              const Height8(),
              const Height8(),
              Text(
                'Pickup',
                style: black14500,
              ),
              RadioListTile(
                value: true,
                groupValue: _option,
                activeColor: accentColor,
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  if (value != null) {
                    _option = value;
                    setState(() {});
                  }
                },
                title: Text(
                  'Old Secretariat Complex, Area 1, Garki Abaji Abji',
                  style: black12400.copyWith(color: mainBlack.withOpacity(0.6)),
                ),
              ),
              RadioListTile(
                value: false,
                activeColor: accentColor,
                groupValue: _option,
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  if (value != null) {
                    _option = value;
                    setState(() {});
                  }
                },
                title: Text(
                  'Sokoto Street, Area 1, Garki Area 1 AMAC',
                  style: black12400.copyWith(color: mainBlack.withOpacity(0.6)),
                ),
              ),
              Text(
                'Delivery',
                style: black14500,
              ),
              const Height8(),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const Height8(),
              const Height8(),
              const Height8(),
              Text(
                'Contact',
                style: black14500,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 2 / 3,
                child: TextField(
                  style: const TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    hintText: 'Phone nos 1',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const Height8(),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 2 / 3,
                child: TextField(
                  style: const TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    hintText: 'Phone nos 2',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const Height8(),
              const Height8(),
              const Height8(),
              PrimaryButton(
                label: 'Complete Order',
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
