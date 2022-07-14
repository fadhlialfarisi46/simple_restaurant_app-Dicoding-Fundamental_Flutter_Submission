import 'package:flutter/material.dart';
import 'package:simple_restaurant_app/data/model/restaurant.dart';
import 'package:simple_restaurant_app/ui/detail_page.dart';
import 'package:simple_restaurant_app/ui/home_page.dart';
import 'package:simple_restaurant_app/ui/splashscreen_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SplashScreenPage.routeName,
      routes: {
        SplashScreenPage.routeName: (context) => const SplashScreenPage(),
        HomePage.routeName: (context) => const HomePage(),
        DetailPage.routeName: (context) => DetailPage(restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant)
      },
    );
  }
}


