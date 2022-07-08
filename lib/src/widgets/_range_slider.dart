import 'package:flutter/material.dart';

import '_range_slider_track_shape.dart';

///
class RangedSlider extends StatelessWidget {
  ///Range Slider widget for strokeWidth
  const RangedSlider({Key? key, this.value, this.onChanged}) : super(key: key);

  ///Default value of strokewidth.
  final double? value;

  /// Callback for value change.
  final ValueChanged<double>? onChanged;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        //trackHeight: 10,
        trackShape: TriangleTrackShape(),
        //activeTrackColor: Colors.purple.shade800,
        //inactiveTrackColor: Colors.purple.shade100,
        thumbShape: RoundSliderThumbShape(
          enabledThumbRadius: value! / 2,
          pressedElevation: 8.0,
        ),
        rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
        thumbColor: Colors.pinkAccent,
        overlayColor: Colors.white.withOpacity(0.2),
        //overlayShape: RoundSliderOverlayShape(overlayRadius: 302.0),
        tickMarkShape: const RoundSliderTickMarkShape(),
        activeTickMarkColor: Colors.pinkAccent,
        inactiveTickMarkColor: Colors.white,
        valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
      ),
      child: Slider(
        //activeColor: Color(0xAAFFFF),
        //inactiveColor: Color(0xAAFFFF),
        thumbColor: Colors.white,
        max: 40,
        min: 10,
        value: value!,
        onChanged: onChanged,
      ),
    );
  }
}
