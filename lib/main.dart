import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shop_bag_app/data/db/cart_db_client.dart';
import 'package:shop_bag_app/data/db/favourites_db_client.dart';
import 'package:shop_bag_app/data/db/orders_db_client.dart';
import 'package:shop_bag_app/data/model/card_details/card_details.dart';
import 'package:shop_bag_app/data/model/cart_item/cart_item.dart';
import 'package:shop_bag_app/data/model/delivery_method/delivery_method.dart';
import 'package:shop_bag_app/data/model/order_contact_details/order_contact_details.dart';
import 'package:shop_bag_app/data/model/order_item/order_item.dart';
import 'package:shop_bag_app/data/model/payment_detail/payment_details.dart';
import 'package:shop_bag_app/data/model/pre_order/pre_order.dart';
import 'package:shop_bag_app/data/model/product/product.dart';
import 'package:shop_bag_app/screens/home.dart';
import 'package:shop_bag_app/state/app_state_notifier.dart';
import 'package:shop_bag_app/state/favouties_state_notifier.dart';
import 'package:shop_bag_app/state/order_state_notifier.dart';
import 'package:shop_bag_app/utils/colors.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(PreOrderAdapter());
  Hive.registerAdapter(PaymentDetailsAdapter());
  Hive.registerAdapter(OrderItemAdapter());
  Hive.registerAdapter(OrderContactDetailsAdapter());
  Hive.registerAdapter(DeliveryMethodAdapter());
  Hive.registerAdapter(CartItemAdapter());
  Hive.registerAdapter(CardDetailsAdapter());

  await Future.wait([
    CartDbClient.openBox(),
    OrdersDbClient.openBox(),
    FavouritesDbClient.openBox(),
  ]);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppStateNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderStateNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoritesStateNotifier(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: mainWhite,
          ),
          textTheme: GoogleFonts.montserratTextTheme(),
        ).copyWith(scaffoldBackgroundColor: Colors.white),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
