import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String label;
  final Function onPress;
  DrawerItem({@required this.label, @required this.onPress});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      child: Text(label),
    );
  }
}
