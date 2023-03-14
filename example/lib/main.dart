import 'package:animated_music_indicator/animated_music_indicator.dart';
import 'package:flutter/material.dart';

// Tapping on a tile will animate that tile's [AnimatedMusicIndicator].

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
        child: AnimatedMusicIndicatorExample(),
      ),
    ),
  );
}

class AnimatedMusicIndicatorExample extends StatefulWidget {
  const AnimatedMusicIndicatorExample({Key? key}) : super(key: key);

  @override
  State<AnimatedMusicIndicatorExample> createState() =>
      _AnimatedMusicIndicatorExampleState();
}

class _AnimatedMusicIndicatorExampleState
    extends State<AnimatedMusicIndicatorExample> {
  int _index = 99;

  void _tileTapped(int index) {
    _index = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    /// Example creates 5 [ListTile] with [AnimatedMusicIndicator] set as trailing.

    return Scaffold(
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) => ListTile(
                leading: const Icon(Icons.audiotrack_outlined),
                onTap: () => _tileTapped(index),
                title: Text('Song ${index + 1}'),
                trailing: AnimatedMusicIndicator(
                  barStyle: BarStyle.dash,
                  color: Colors.orangeAccent,
                  animate: index == _index,
                ),
              )),
    );
  }
}
