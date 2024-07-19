bool isValidNigerianPhoneNumber(String phoneNumber) {
  if (phoneNumber.isEmpty) {
    return false;
  } else if (phoneNumber.isNotEmpty) {
    return RegExp(r'^0[7-9]{1}[0-1]{1}[0-9]{8}$').hasMatch(phoneNumber);
  }

  return false;
}

bool validateExpiryDate(String date) {
  final regex = RegExp(r'^([0][1-9]|1[0-2])\/([0-9]{2})$');

  if (!regex.hasMatch(date)) {
    return false; // Invalid format
  }

  return true; // Valid date
}

bool validateMonth(String date) {
  final parts = date.split('/');
  final month = int.parse(parts[0]);

  if (month < 1 || month > 12) {
    return false; // Invalid month
  }
  return true;
}

bool verifyExpiryYear(String date) {
  final parts = date.split('/');
  final year = int.parse(parts[1]);
  final currentYear =
      DateTime.now().year % 100; // Last two digits of current year
  if (year < currentYear) {
    return false; // Year is too old
  }
  return true;
}
