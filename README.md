# Creates animated bars to indicate when music is playing.

Simply place the **AnimatedMusicIndicator** where you want it to be displayed in your app:

![Alt Text](https://github.com/Kerandon/animated_music_indicator/blob/main/images/house_example.gif)

# Features

You can customize the music bars, including selecting one of three styles: **solid**, **circle** & **dash**.


<p float="center">
  <img src="https://github.com/Kerandon/animated_music_indicator/blob/main/images/solid.gif" width="150" />
  <img src="https://github.com/Kerandon/animated_music_indicator/blob/main/images/circles.gif" width="150" /> 
  <img src="https://github.com/Kerandon/animated_music_indicator/blob/main/images/dashes.gif" width="150" />
</p>

###### Animation

<p float="center">
  <img src="https://github.com/Kerandon/animated_music_indicator/blob/main/images/animate_example.gif" width="150" />
</p>

The bars will animate automatically by default. However, you can control when the
animation runs by passing in a boolean value to **animate**.

###### Size

Size can be changed by passing in a double value to **size**. Size is based off the width of the device
and the default is 10% (0.1).

## Usage

**Simple example:**

```

AnimatedMusicIndicator();


```

**Customized example:**

<p float="center">
  <img src="https://github.com/Kerandon/animated_music_indicator/blob/main/images/color_dash_bars_example.gif" width="250" />
</p>

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
