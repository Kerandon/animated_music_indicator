# Display an animated equalizer to indicate music is playing.

![Alt Text](https://github.com/Kerandon/animated_music_indicator/blob/main/images/house_example.gif)

## Features

You can customize by selecting one of three styles: **1. solid**, **2. circle** & **3. dash**.

![Alt Text](https://github.com/Kerandon/animated_music_indicator/blob/main/images/Three_styles_gif.gif)

## Animation


![Alt Text](img src="https://github.com/Kerandon/animated_music_indicator/blob/main/images/animate_example.gif)

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

![Alt Text](img src="https://github.com/Kerandon/animated_music_indicator/blob/main/images/color_dash_bars_example.gif)
