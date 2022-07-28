import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:simple_restaurant_app/utils/background_service.dart';
import 'package:simple_restaurant_app/utils/datetime_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  final id = 1;

  Future<bool> scheduleNotification(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      if (kDebugMode) {
        print('Scheduling Notification Activated');
      }
      notifyListeners();

      return await AndroidAlarmManager.periodic(
          const Duration(days: 1), id, BackgroundService.callback,
          startAt: DateTimeHelper.format(), exact: true, wakeup: true);
    } else {
      if (kDebugMode) {
        print('Scheduling Notification Canceled');
      }
      notifyListeners();

      return await AndroidAlarmManager.cancel(id);
    }
  }
}
