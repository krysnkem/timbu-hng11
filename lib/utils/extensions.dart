import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_bag_app/state/app_state.dart';

extension ContextExt on BuildContext {
  AppState getAppState() => AppStateScope.of(this);
}

extension StringExt on String {
  String get cleanText {
    String decoded = utf8.decode(runes.toList());
    // Normalize the string to remove any non-standard characters
    String normalized = decoded.replaceAll(RegExp(r'[\uFFFD]'), '');
    return normalized;
  }

  String get capitalize {
    if (isEmpty) return this; // Return empty string if input is empty

    List<String> words = split(' ');
    List<String> capitalizedWords = words.map((word) {
      if (word.isEmpty) return word; // Return empty word if input word is empty
      return word.substring(0, 1).toUpperCase() + word.substring(1);
    }).toList();

    return capitalizedWords.join(' ');
  }

  String get formattedAmount {
    return  replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},') ;
  }
}
