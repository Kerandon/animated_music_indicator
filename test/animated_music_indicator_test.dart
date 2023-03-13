import 'package:animated_music_indicator/animated_music_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'BarPainter widgets are shown',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AnimatedMusicIndicator(),
        ),
        const Duration(milliseconds: 1000),
      );
      final finder = find.byType(CustomPaint);
      expect(finder, findsWidgets);
    },
  );
}
