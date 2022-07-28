import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/preferences_provider.dart';
import '../provider/scheduling_provider.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/settings_page';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return ListView(
            children: [
              Material(
                child: ListTile(
                  title: const Text('Daily Notification'),
                  subtitle: const Text('Give you restaurant recommendations'),
                  trailing: Consumer<SchedulingProvider>(
                    builder: (context, scheduled, _) {
                      return Switch.adaptive(
                        value: provider.isDailyNotif,
                        onChanged: (value) async {
                          scheduled.scheduleNotification(value);
                          provider.enableDailyNotif(value);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
