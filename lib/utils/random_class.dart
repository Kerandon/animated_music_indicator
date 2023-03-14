import 'dart:math';

/// A simple utility class to create a random double or int between a given range.
/// The random values are used to create randomness in the bar animation.

class RandomClass {
  static Random random = Random();

  static int calculateIntInRange(int min, int max) =>
      min + random.nextInt(max - min);

  static double calculateDoubleInRange(double min, double max) {
    return random.nextDouble() * (max - min) + min;
  }
}
