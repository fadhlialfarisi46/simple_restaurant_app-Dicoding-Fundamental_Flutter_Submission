import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simple_restaurant_app/ui/home_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  static const routeName = '/splashscreen_page';

  @override
  State<StatefulWidget> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  Future<Timer> startSplashScreen() async {
    const duration = Duration(seconds: 2);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return const HomePage();
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CircleAvatar(
          radius: MediaQuery.of(context).size.shortestSide * .3,
          backgroundColor: Colors.red,
          child: const Text("Restaurant App", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 32),
        ),),
    )
    );
  }
}