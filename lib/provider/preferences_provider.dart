import 'package:flutter/cupertino.dart';
import 'package:simple_restaurant_app/data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getDailyNotifPreferences();
  }

  bool _isDailyNotif = false;
  bool get isDailyNotif => _isDailyNotif;

  void _getDailyNotifPreferences() async {
    _isDailyNotif = await preferencesHelper.isScheduleNotifActive;
    notifyListeners();
  }

  void enableDailyNotif(bool value) {
    preferencesHelper.setDailyNotif(value);
    _getDailyNotifPreferences();
  }
}
