import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    required this.leading,
    required this.title,
  });

  final Widget leading;

  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ), //adjust the padding as you want
        child: SafeArea(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: leading,
              ),
              const Spacer(),
              title ?? const SizedBox(),
              const Spacer(
                flex: 5,
              )
            ],
          ),
        ), //or row/any widget
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
