import 'package:flutter/material.dart';

class BackGround extends StatelessWidget {
  const BackGround({this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blueGrey.shade100,
            Colors.blueGrey.shade100,
          ],
        ),
      ),
      child: child,
    );
  }
}
