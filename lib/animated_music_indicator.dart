import 'package:animated_music_indicator/bar_painter.dart';
import 'package:animated_music_indicator/utils/random_class.dart';
import 'package:flutter/material.dart';

/// Creates customizable animating music bars to indicate music is being played.

/// [AnimatedMusicIndicator] can be set to one of three [BarStyle]s:

enum BarStyle {
  solid,
  dash,
  circle,
}

/// If no arguments are supplied [AnimatedMusicIndicator] will animate by default
/// 5 bars in [Colors.white].

class AnimatedMusicIndicator extends StatefulWidget {
  const AnimatedMusicIndicator({
    Key? key,

    /// Either a single color OR multiple colors can be set.
    /// Default color is [Colors.white].

    this.color,
    this.colors,
    this.numberOfBars = 5,

    /// There are 3 styles to select from [BarStyle.solid], [BarStyle.dash] and [BarStyle.circle].

    this.barStyle = BarStyle.solid,
    this.backgroundColor = Colors.transparent,
    this.curveBackgroundCorners = true,

    /// Round the bar ends.

    this.roundBars = true,

    /// Allows control of when the bars animate. If animation is stopped, no bars will show.

    this.animate = true,

    /// Size is based as a proportion of the device's screen width.

    this.size = 0.10,
  })  : assert(
          colors != null ? colors.length == numberOfBars : true,
          'Colors list length must equal number of bars',
        ),
        assert(color != null && colors != null ? false : true,
            'Cannot provide both a Color and a list of Colors'),
        assert(numberOfBars >= 1 && numberOfBars <= 10,
            'Number of bars must be between 1 and 10 inclusive'),
        assert(size >= 0.05 && size <= 1.0,
            'Size must be a value between 0.05 and 1.0 inclusive'),
        super(key: key);
  final Color? color;
  final List<Color>? colors;
  final int numberOfBars;
  final BarStyle barStyle;
  final bool roundBars;
  final bool animate;
  final Color backgroundColor;
  final bool curveBackgroundCorners;
  final double size;

  @override
  State<AnimatedMusicIndicator> createState() => _AnimatedMusicIndicatorState();
}

class _AnimatedMusicIndicatorState extends State<AnimatedMusicIndicator>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers = [];
  final List<Animation<double>> _animators = [];

  /// A random duration will be selected in milliseconds based on the min and max time,
  /// to set how long a bar will complete its animation up and down.

  final int minBarTime = 1500;
  final int maxBarTime = 3500;

  @override
  void initState() {
    /// Initializes the [AnimationController] objects, each representing a single bar.

    _controllers.addAll(generateControllers(
      tickerProvider: this,
      numberOfBars: widget.numberOfBars,
      minBarTime: minBarTime,
      maxBarTime: maxBarTime,
    ));
    _animators.addAll(generateAnimations(
      controllers: _controllers,
      numberOfBars: widget.numberOfBars,
    ));

    /// Initializes the [Animation] objects each representing a single bar.
    /// After each animation has completed, [Animation] will be
    /// removed from [_animators] list, and a new [Animation] object generated
    /// and inserted into the list, in order to create dynamic height values.
    ///
    /// Animation will be triggered in [initState] override method by default.

    for (int i = 0; i < widget.numberOfBars; i++) {
      if (widget.animate) {
        _controllers[i]
            .forward(from: RandomClass.calculateDoubleInRange(0, 0.50));
      }
      _controllers[i].addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animators.removeAt(i);
          _animators.insert(
              i,
              generateAnimations(
                  controllers: _controllers,
                  numberOfBars: widget.numberOfBars)[i]);
          _controllers[i].reset();
          if (widget.animate) {
            _controllers[i].forward();
          }
        }
      });
    }
    super.initState();
  }

  /// [didUpdateWidget] override method used to control the animation if a 'true' or 'false' value is passed in after init.

  @override
  void didUpdateWidget(covariant AnimatedMusicIndicator oldWidget) {
    if (widget.animate) {
      for (var element in _controllers) {
        element.forward();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.removeStatusListener((status) {});
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final totalWidth = size.width * widget.size;
    return SizedBox(
      width: totalWidth,
      height: totalWidth * 0.80,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final double cornerRadius = maxWidth * 0.02;
          return ClipRRect(
            borderRadius: BorderRadius.circular(
                widget.curveBackgroundCorners ? cornerRadius : 0),
            child: Container(
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(
                    widget.curveBackgroundCorners ? cornerRadius : 0),
              ),

              /// Generates a [Row] of [CustomPainter] each representing a single bar
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.animate)
                    ...List.generate(
                      widget.numberOfBars,
                      (index) => AnimatedBuilder(
                        animation: _controllers[index],
                        builder: (context, child) => SizedBox(
                          width: maxWidth / widget.numberOfBars,
                          height: maxWidth * 2,
                          child: CustomPaint(
                            painter: BarPainter(
                                color: widget.colors == null
                                    ? widget.color ?? Colors.white
                                    : widget.colors![index],
                                progress: _animators[index].value,
                                roundBars: widget.roundBars,
                                barStyle: widget.barStyle),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Generates a list of controllers all set to a random duration period.

List<AnimationController> generateControllers(
    {required TickerProvider tickerProvider,
    required int numberOfBars,
    required int minBarTime,
    required maxBarTime}) {
  List<AnimationController> controllers = [];
  for (int i = 0; i < numberOfBars; i++) {
    final milliseconds =
        RandomClass.calculateIntInRange(minBarTime, maxBarTime);
    controllers.add(AnimationController(
        duration: Duration(milliseconds: milliseconds), vsync: tickerProvider));
  }
  return controllers;
}

/// Generates a list of animation objects linked to a [TweenSequence],
/// which will control the animation height.

List<Animation<double>> generateAnimations(
    {required List<AnimationController> controllers,
    required int numberOfBars}) {
  List<Animation<double>> animations = [];

  for (int i = 0; i < numberOfBars; i++) {
    final heightMin = RandomClass.calculateDoubleInRange(0.0, 0.50);
    final heightMax = RandomClass.calculateDoubleInRange(0.60, 0.95);

    animations.add(TweenSequence([
      TweenSequenceItem(
          tween: Tween<double>(begin: 0, end: heightMin), weight: 0.10),
      TweenSequenceItem(
          tween: Tween<double>(begin: heightMin, end: heightMax),
          weight: RandomClass.calculateDoubleInRange(0.20, 1.5)),
      TweenSequenceItem(
          tween: Tween<double>(begin: heightMax, end: heightMax),
          weight: RandomClass.calculateDoubleInRange(0.0, 0.30)),
      TweenSequenceItem(
          tween: Tween<double>(begin: heightMax, end: heightMin),
          weight: RandomClass.calculateDoubleInRange(0.10, 0.50)),
      TweenSequenceItem(
          tween: Tween<double>(begin: heightMin, end: 0), weight: 0.10),
    ]).animate(
        CurvedAnimation(parent: controllers[i], curve: Curves.bounceOut)));
  }

  return animations;
}
