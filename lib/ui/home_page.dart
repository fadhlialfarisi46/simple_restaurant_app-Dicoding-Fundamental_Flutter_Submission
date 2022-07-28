import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_restaurant_app/common/navigation_route.dart';
import 'package:simple_restaurant_app/extension/state_management.dart';
import 'package:simple_restaurant_app/provider/restaurants_provider.dart';
import 'package:simple_restaurant_app/ui/detail_page.dart';
import 'package:simple_restaurant_app/ui/favorite_page.dart';
import 'package:simple_restaurant_app/ui/search_page.dart';
import 'package:simple_restaurant_app/ui/settings_page.dart';
import 'package:simple_restaurant_app/utils/notification_helper.dart';
import 'package:simple_restaurant_app/widget/widget_item_restaurants.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(DetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Restaurant App',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              Navigation.intent(SearchPage.routeName);
            },
            child: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            key: const Key('search_page_button'),
          ),
          GestureDetector(
            onTap: () {
              Navigation.intent(FavoritePage.routeName);
            },
            child: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            key: const Key('favorite_page_button'),
          ),
          GestureDetector(
            onTap: () {
              Navigation.intent(SettingsPage.routeName);
            },
            child: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
            key: const Key('settings_page_button'),
          ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: Consumer<RestaurantsProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.state == ResultState.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var restaurant = state.result.restaurants[index];
                return ItemRestaurants(restaurant: restaurant);
              },
              itemCount: state.result.restaurants.length,
            );
          } else if (state.state == ResultState.noData) {
            return Center(
              child: Text(state.message),
            );
          } else if (state.state == ResultState.error) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(child: Text(''));
          }
        },
      ),
    );
  }
}
