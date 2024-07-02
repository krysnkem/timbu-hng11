import 'package:flutter/material.dart';
import 'package:shop_bag_app/screens/home.dart';
import 'package:shop_bag_app/state/app_state.dart';
import 'package:shop_bag_app/utils/colors.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppStateWidget(
      child: MaterialApp(
        theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: appPrimaryColor,
          ),
        ).copyWith(scaffoldBackgroundColor: Colors.white),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
