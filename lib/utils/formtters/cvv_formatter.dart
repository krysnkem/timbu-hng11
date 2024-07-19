import 'package:flutter/services.dart';

class CVVNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll(' ', '');

    if (text.length > 3) {
      return oldValue;
    }

    return newValue;
  }
}
