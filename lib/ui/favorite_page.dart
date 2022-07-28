import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_restaurant_app/extension/state_management.dart';
import 'package:simple_restaurant_app/provider/database_provider.dart';
import 'package:simple_restaurant_app/widget/widget_item_restaurants.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = '/favorite_page';

  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Favorite Restaurants',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Consumer<DatabaseProvider>(builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var restaurant = state.favorites[index];
              return ItemRestaurants(restaurant: restaurant);
            },
            itemCount: state.favorites.length,
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
      }),
    );
  }
}
