import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onPress;
  DrawerItem(
      {@required this.text, @required this.icon, @required this.onPress});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ListTile(
        onTap: onPress,
        trailing: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        leading: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
