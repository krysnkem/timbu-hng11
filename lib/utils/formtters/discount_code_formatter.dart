import 'package:flutter/services.dart';

class DiscountCodeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll(' ', '');

    if (text.length > 6) {
      return oldValue;
    }

    return newValue;
  }
}
