import 'package:flutter/material.dart';
import 'package:shop_bag_app/utils/text_styles.dart';

class MyCart extends StatelessWidget {
  const MyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'My Cart',
          style: pageTitleStyle,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text('Checkout'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Check out'),
          )
        ],
      ),
    );
  }
}
