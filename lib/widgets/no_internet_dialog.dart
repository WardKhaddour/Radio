import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/music_screen.dart';
import '../constatnts.dart';

class NoInternetDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'You are not connected to the internet',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 20,
        ),
      ),
      content: Image.asset(noSignal),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(
              MusicScreen.routeName,
              arguments: true,
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
        // ListTile(
        //   title: Text('Set as default'),
        //   trailing: Checkbox(
        //     value: false,
        //     onChanged: (value) async {
        //       if (value) {
        //         final pref = await SharedPreferences.getInstance();
        //         pref.setString('default', 'music');
        //       }
        //     },
        //   ),
        // ),
      ],
    );
  }
}
