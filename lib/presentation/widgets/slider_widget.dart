import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({
    super.key,
    required this.onSlide,
    this.divisions = 6,
    this.value,
    this.thumbColor = Colors.white,
  });

  @override
  _SliderWidgetState createState() => _SliderWidgetState();

  final int divisions;
  final Color thumbColor;
  final double? value;
  final void Function(double) onSlide;
}

class _SliderWidgetState extends State<SliderWidget> {
  double _value = 0;

  @override
  Widget build(BuildContext context) => SliderTheme(
        data: SliderTheme.of(context).copyWith(
            trackShape: CustomTrackShape(),
            valueIndicatorShape: SliderComponentShape.noThumb,
            activeTrackColor: Colors.black,
            inactiveTrackColor: Colors.black54,
            trackHeight: 4.5,
            thumbColor: widget.thumbColor,
            activeTickMarkColor: Colors.white,
            tickMarkShape: CustomSliderTickMarkShape(),
            inactiveTickMarkColor: Colors.white),
        child: Slider(
          divisions: widget.divisions,
          value: widget.value ?? _value,
          onChangeEnd: (value) {
            widget.onSlide(value);
          },
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
        ),
      );
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 4;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class CustomSliderTickMarkShape extends SliderTickMarkShape {
  @override
  Size getPreferredSize(
      {required SliderThemeData sliderTheme, required bool isEnabled}) {
    return const Size(8, 8);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final Canvas canvas = context.canvas;
    final Paint paint = Paint()
      ..color = sliderTheme.activeTickMarkColor!
      ..strokeWidth = 3
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 2, paint);
  }
}
