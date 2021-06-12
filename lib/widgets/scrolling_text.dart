import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class ScrollingText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  ScrollingText({@required this.text, this.textStyle});
  @override
  Widget build(BuildContext context) {
    return Marquee(
      text: ' $text ',
      style: textStyle,
      // pauseAfterRound: Duration(milliseconds: 300),
      startPadding: 10.0,
      accelerationDuration: Duration(milliseconds: 5),
      accelerationCurve: Curves.easeInOut,
      decelerationDuration: Duration(milliseconds: 5),
      decelerationCurve: Curves.easeOut,
    );
  }
}
