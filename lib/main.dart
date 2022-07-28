import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_restaurant_app/common/navigation_route.dart';
import 'package:simple_restaurant_app/data/api/api_service.dart';
import 'package:simple_restaurant_app/data/db/db_helper.dart';
import 'package:simple_restaurant_app/data/model/restaurant.dart';
import 'package:simple_restaurant_app/data/preferences/preferences_helper.dart';
import 'package:simple_restaurant_app/provider/database_provider.dart';
import 'package:simple_restaurant_app/provider/preferences_provider.dart';
import 'package:simple_restaurant_app/provider/restaurants_provider.dart';
import 'package:simple_restaurant_app/provider/scheduling_provider.dart';
import 'package:simple_restaurant_app/ui/detail_page.dart';
import 'package:simple_restaurant_app/ui/favorite_page.dart';
import 'package:simple_restaurant_app/ui/home_page.dart';
import 'package:simple_restaurant_app/ui/search_page.dart';
import 'package:simple_restaurant_app/ui/settings_page.dart';
import 'package:simple_restaurant_app/ui/splashscreen_page.dart';
import 'package:simple_restaurant_app/utils/background_service.dart';
import 'package:simple_restaurant_app/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotification(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => RestaurantsProvider(apiService: ApiService())),
        ChangeNotifierProvider(
            create: (_) => DatabaseProvider(dbHelper: DbHelper())),
        ChangeNotifierProvider(
            create: (_) => PreferencesProvider(
                preferencesHelper: PreferencesHelper(
                    sharedPreferences: SharedPreferences.getInstance()))),
        ChangeNotifierProvider(create: (_) => SchedulingProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorKey: navigatorKey,
        initialRoute: SplashScreenPage.routeName,
        routes: {
          SplashScreenPage.routeName: (context) => const SplashScreenPage(),
          HomePage.routeName: (context) => const HomePage(),
          SearchPage.routeName: (context) => const SearchPage(),
          FavoritePage.routeName: (context) => const FavoritePage(),
          SettingsPage.routeName: (context) => const SettingsPage(),
          DetailPage.routeName: (context) {
            final arguments =
                ModalRoute.of(context)?.settings.arguments as Restaurant;
            return DetailPage(detailRestaurant: arguments);
          }
        },
      ),
    );
  }
}
