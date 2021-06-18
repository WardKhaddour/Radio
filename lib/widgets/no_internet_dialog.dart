import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/music_screen.dart';
import '../constatnts.dart';

class NoInternetDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'You Are Not Connected To Internet',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 24,
        ),
      ),
      content: Image.asset(noSignal),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(
              MusicScreen.routeName,
            );
          },
          child: Text(
            'Play Music',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            SystemNavigator.pop();
          },
          child: Text(
            'Close',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
