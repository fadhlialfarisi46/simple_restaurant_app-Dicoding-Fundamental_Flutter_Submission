import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:simple_restaurant_app/data/api/api_service.dart';
import 'package:simple_restaurant_app/utils/notification_helper.dart';

import '../main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _sendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<void> callback() async {
    if (kDebugMode) {
      print('Alarm fired');
    }

    final NotificationHelper _notificationhelper = NotificationHelper();

    var result = await ApiService().listRestaurants();
    final _random = Random();
    var restaurant =
        result.restaurants[_random.nextInt(result.restaurants.length)];

    await _notificationhelper.showNotification(
        flutterLocalNotificationsPlugin, restaurant);

    _sendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _sendPort?.send(null);
  }
}
