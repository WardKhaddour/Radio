import 'package:flutter/material.dart';

class AppBarFlexibleSpace extends StatelessWidget {
  const AppBarFlexibleSpace({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          end: Alignment.topRight,
          begin: Alignment.bottomLeft,
          colors: [
            // Colors.teal.shade100,
            // Colors.teal.shade200,
            Colors.teal.shade300,
            Colors.teal.shade400,
            Colors.teal.shade500,
            // Colors.teal.shade600,
            // Colors.teal.shade700,
            // Colors.teal.shade600,
            Colors.teal.shade500,
            Colors.teal.shade400,
            Colors.teal.shade300,
          ],
        ),
      ),
    );
  }
}
