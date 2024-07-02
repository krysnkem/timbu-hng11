import 'package:flutter/material.dart';
import 'package:shop_bag_app/state/app_state.dart';

extension ContextExt on BuildContext {
  AppState getAppState() => AppStateScope.of(this);
}
