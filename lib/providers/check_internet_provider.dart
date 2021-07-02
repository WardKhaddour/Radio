import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
// import 'package:connectivity/connectivity.dart';

class CheckInternet with ChangeNotifier {
  bool _isConnected = false;
  bool get isConnected {
    return _isConnected;
  }

  // Stream<ConnectivityResult> get onConnectivityChanged {
  //   return Connectivity().onConnectivityChanged;
  // }

  Future<void> getConnection() async {
    final result = await InternetAddress.lookup('google.com');
    try {
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _isConnected = true;
      }
    } on SocketException {
      _isConnected = false;
    }
    notifyListeners();
  }

//   Future<void> getConnectionStatus() async {
//     ConnectivityResult result = await Connectivity().checkConnectivity();
//     if (result == ConnectivityResult.none) {
//       _isConnected = false;
//     } else {
//       _isConnected = true;
//     }
//     onConnectivityChanged.listen((event) {
//       getConnectionStatus();
//     });
//     notifyListeners();
//   }
}
