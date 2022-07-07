import 'dart:async';
import 'package:app_turismo/main.dart';
import 'package:app_turismo/utils/check_internet_connection.dart';
import 'package:flutter/material.dart';

class ConnectionStatusChangeNotifier extends ChangeNotifier {
  late StreamSubscription _connectionSubscription;
  ConnectionStatus status = ConnectionStatus.online;

  ConnectionStatusChangeNotifier() {
    _connectionSubscription =
        internetChecker.internetStatus().listen((newStatus) {
      status = newStatus;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _connectionSubscription.cancel();
    super.dispose();
  }
}
