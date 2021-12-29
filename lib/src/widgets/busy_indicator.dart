import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BusyIndicator extends StatelessWidget {
  final Widget indicator;

  const BusyIndicator._(this.indicator);
  factory BusyIndicator({Color? color, double size = 20.0}) => BusyIndicator._(SpinKitThreeBounce(color: color, size: size));

  factory BusyIndicator.accent(BuildContext context, {double size = 20.0}) {
    return BusyIndicator._(SpinKitThreeBounce(color: Theme.of(context).colorScheme.secondary, size: size));
  }

  factory BusyIndicator.round({Color color = const Color(0xFF2F333A), double size = 50.0}) {
    return BusyIndicator._(Stack(
      children: <Widget>[
        Center(
          child: SizedBox.fromSize(
            size: Size.square(size),
            child: CustomPaint(
              willChange: false,
              foregroundPainter: RingPainter(
                paintWidth: 4,
                trackColor: const Color(0xFFC5C5C5),
                progressPercent: 1,
                startAngle: pi * 0,
              ),
            ),
          ),
        ),
        SpinKitRing(color: color, lineWidth: 4, size: size),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) => indicator;
}
