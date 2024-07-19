import 'package:flutter/material.dart';
import 'package:shop_bag_app/state/app_state_model.dart';
import 'package:shop_bag_app/state/app_state_notifier.dart';

class AppStateWidget extends StatefulWidget {
  const AppStateWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  static AppStateNotifier of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AppStateModel>()!
        .notifier;
  }

  @override
  State<AppStateWidget> createState() => AppStateWidgetState();
}

class AppStateWidgetState extends State<AppStateWidget> {
  final AppStateNotifier appStateNotifier = AppStateNotifier();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppStateModel(
      notifier: appStateNotifier,
      child: widget.child,
    );
  }
}
