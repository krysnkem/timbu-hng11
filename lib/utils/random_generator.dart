import 'dart:math';

class RandomGenerator {
  RandomGenerator._();
  // Generate a random delivery fee between 2000 and 5000 in multiples of 100
  static int generateDeliveryFee() {
    final random = Random();
    int min = 2000;
    int max = 5000;
    int step = 100;
    int range = (max - min) ~/ step + 1;
    return min + (random.nextInt(range) * step);
  }

  // Generate a random discount amount between 20 and 75
  static int generateDiscountAmount() {
    final random = Random();
    int min = 20;
    int max = 75;
    return min + random.nextInt(max - min + 1);
  }
}
