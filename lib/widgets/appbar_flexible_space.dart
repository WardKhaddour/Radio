import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class AppBarFlexibleSpace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: !Provider.of<ThemeProvider>(context).isDarkTheme
            ? LinearGradient(
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
              )
            : LinearGradient(
                end: Alignment.topRight,
                begin: Alignment.bottomLeft,
                colors: [
                  Colors.black26,
                  Colors.black38,
                  Colors.black45,
                  Colors.black54,
                  Colors.black87,
                ],
              ),
      ),
    );
  }
}
