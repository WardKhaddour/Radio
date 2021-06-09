import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/music_screen.dart';
import '../constatnts.dart';

class NoInternetDialog extends StatelessWidget {
  const NoInternetDialog({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'You Are Not Connected To Internet',
          style: TextStyle(
            color: Colors.teal,
            fontSize: 24,
          ),
        ),
        Image.asset(noSignal),
        Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(
                  MusicScreen.routeName,
                );
              },
              child: Text(
                'Play Music',
                style: TextStyle(
                  color: Colors.teal,
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
        )
      ],
    );
  }
}
