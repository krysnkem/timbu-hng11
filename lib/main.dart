import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop_bag_app/screens/home.dart';
import 'package:shop_bag_app/state/app_state_notifier.dart';
import 'package:shop_bag_app/state/favouties_state_notifier.dart';
import 'package:shop_bag_app/state/order_state_notifier.dart';
import 'package:shop_bag_app/utils/colors.dart';

void main() {
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
