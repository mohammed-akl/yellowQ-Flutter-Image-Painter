import 'package:flutter/material.dart';

class TriangleTrackShape extends SliderTrackShape {

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    SliderThemeData? sliderTheme,
    bool? isEnabled,
    bool? isDiscrete,
  }) {
    final double thumbWidth =
        sliderTheme!.thumbShape!.getPreferredSize(true, isDiscrete!).width;
    const double trackHeight = 2.0;
    assert(thumbWidth >= 0);
    assert(trackHeight >= 0);
    assert(parentBox.size.width >= thumbWidth);
    assert(parentBox.size.height >= trackHeight);

    final double trackLeft = offset.dx + thumbWidth / 2;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width - thumbWidth;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
      PaintingContext context,
      Offset offset, {
        required RenderBox parentBox,
        SliderThemeData? sliderTheme,
        Animation<double>? enableAnimation,
        TextDirection? textDirection,
        Offset? thumbCenter,
        bool? isDiscrete,
        bool? isEnabled,
      }) {
    if (sliderTheme!.trackHeight == 0) {
      return;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    // Paint color for active and inactive segments of the track. We can also define the colors to be gradient here.
    final Paint activePaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;
    final Paint inactivePaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    Paint leftTrackPaint = activePaint;
    Paint rightTrackPaint = inactivePaint;

    // For LTR/RTL support.
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
        break;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
        break;
    }

    // Since the triangle resembles the right triangle find the y co-ordinate (height with respect to the selection value, so the path of active and inactive segements can be drawn)
    const double trackHeightVariation = 12;
    const double trackShiftAlongY = 6; // Shift the track so that the thumb will be placed in the center.
    final double trackDistance = (trackRect.right - trackRect.left).abs();
    final double customTrackHeight =
    (trackRect.bottom - (trackRect.top - trackHeightVariation));
    final valuePercent = ((thumbCenter!.dx - trackRect.left) / 1).abs();
    final yPoint = ((customTrackHeight / trackDistance) * valuePercent);

    double width = 292;
    final size = Size(width, (width*0.13013698630136986).toDouble());

    final activePathSegment = Path()
    ..moveTo(size.width,size.height*0.6200000)
    ..cubicTo(size.width,size.height*0.8380000,size.width*0.9688356,size.height*1.010000,size.width*0.9315068,size.height)
    ..lineTo(size.width*0.01506849,size.height*0.7180000)
    ..cubicTo(size.width*0.006506849,size.height*0.7160000,size.width*-7.908438e-17,size.height*0.6760000,size.width*-7.908438e-17,size.height*0.6260000)
    ..cubicTo(size.width*-7.908438e-17,size.height*0.5760000,size.width*0.006506849,size.height*0.5360000,size.width*0.01506849,size.height*0.5320000)
    ..lineTo(size.width*0.9315068,size.height*0.2420000)
    ..cubicTo(size.width*0.9688356,size.height*0.2300000,size.width,size.height*0.4020000,size.width,size.height*0.6200000)
    ..close();

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    //paint_0_fill.color = Colors.red.withOpacity(1.0);

    final inactivePathSegment = Path()
      /*..moveTo(thumbCenter.dx, trackRect.bottom + trackShiftAlongY)
      ..lineTo(thumbCenter.dx, trackRect.top - yPoint + trackShiftAlongY)
      ..lineTo(trackRect.right,
          trackRect.top - trackHeightVariation + trackShiftAlongY)
      ..lineTo(trackRect.right, trackRect.bottom + trackShiftAlongY)
      ..close();*/

      ..moveTo(size.width*0.9315377,size.height*0.002297868)
      ..lineTo(size.width*0.01507130,size.height*0.3853421)
      ..cubicTo(size.width*0.006618425,size.height*0.3888737,0,size.height*0.4425737,0,size.height*0.5076237)
      ..cubicTo(0,size.height*0.5727684,size.width*0.006637158,size.height*0.6265105,size.width*0.01510329,size.height*0.6299184)
      ..lineTo(size.width*0.9316678,size.height*0.9988132)
      ..cubicTo(size.width*0.9688151,size.height*1.013766,size.width,size.height*0.7863553,size.width,size.height*0.5005289)
      ..cubicTo(size.width,size.height*0.2143082,size.width*0.9687329,size.height*-0.01324718,size.width*0.9315377,size.height*0.002297868)
      ..close();

    context.canvas.drawPath(activePathSegment, activePaint);
    //context.canvas.drawPath(inactivePathSegment, inactivePaint);
    // If we want shadows to the track or active portion we can define that and draw that.
  }
}