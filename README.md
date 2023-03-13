# Display animated bars to indicate music is playing.

![Alt Text](https://github.com/Kerandon/animated_music_indicator/blob/main/images/house_example.gif)

## Features

You can customize by selecting one of three styles: **solid**, **circle** & **dash**.


<p float="center">
  <img src="https://github.com/Kerandon/animated_music_indicator/blob/main/images/solid.gif" width="50" />
  <img src="https://github.com/Kerandon/animated_music_indicator/blob/main/images/circles.gif" width="50" /> 
  <img src="https://github.com/Kerandon/animated_music_indicator/blob/main/images/dashes.gif" width="50" />
</p>

## Animation

<p float="center">
  <img src="https://github.com/Kerandon/animated_music_indicator/blob/main/images/animate_example.gif" width="150" />
</p>

You can control the animation by passing a boolean to **animate**.

## Usage

**Simple example:**

```

AnimatedMusicIndicator();


```

**Customized example:**

```

              AnimatedMusicIndicator(
                animate: _animate,
                numberOfBars: 8,
                size: 0.50,
                backgroundColor: Colors.white,
                barStyle: BarStyle.dash,
                roundBars: false,
                colors: const [
                  Colors.red,
                  Colors.blue,
                  Colors.green,
                  Colors.black,
                  Colors.greenAccent,
                  Colors.purpleAccent,
                  Colors.lightGreen,
                  Colors.lightBlue,
                ],
              );
              
```

<p float="center">
  <img src="https://github.com/Kerandon/animated_music_indicator/blob/main/images/color_dash_bars_example.gif" width="250" />
</p>

# Installing:

In your pubspec.yaml:

```

dependencies:
  animated_music_indicator: ^0.0.1
  
```

The import statement:

```

import 'package:animated_music_indicator/animated_music_indicator.dart';

```
