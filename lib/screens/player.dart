// import 'package:flutter/material.dart';
// import '../constatnts.dart';

// class Player extends StatelessWidget {
//   static const routeName = '/player';
//   final String imageURL;
//   final String songName;
//   final String url;
//   Player({this.imageURL, this.songName, this.url});
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//           Container(
//             child: FadeInImage(
//               placeholder: AssetImage(cd),
//               image: NetworkImage(imageURL),
//             ),
//           ),
//           Text(songName),
//           Divider(),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(
//                   icon: Icon(
//                     Icons.skip_previous,
//                     size: 40,
//                   ),
//                   onPressed: () {}),
//               IconButton(
//                   icon: Icon(
//                     Icons.pause,
//                     size: 40,
//                   ),
//                   onPressed: () {}),
//               IconButton(
//                   icon: Icon(
//                     Icons.skip_next,
//                     size: 40,
//                   ),
//                   onPressed: () {}),
//             ],
//           ),
//         ]),
//       ),
//     );
//   }
// }
