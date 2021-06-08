import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:connectivity/connectivity.dart';

class CheckInternet with ChangeNotifier {
  bool _isConnected = true;
  bool get isConnected {
    return _isConnected;
  }

  Stream<ConnectivityResult> get onConnectivityChanged {
    return Connectivity().onConnectivityChanged;
  }

  Future<void> getConnectionStatus() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _isConnected = false;
    } else {
      _isConnected = true;
    }
    onConnectivityChanged.listen((event) {
      getConnectionStatus();
    });
    notifyListeners();
  }
}
