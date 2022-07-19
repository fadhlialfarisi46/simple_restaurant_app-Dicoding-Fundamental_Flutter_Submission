import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_restaurant_app/data/api/api_service.dart';
import 'package:simple_restaurant_app/extension/state_management.dart';
import 'package:simple_restaurant_app/provider/restaurants_provider.dart';
import 'package:simple_restaurant_app/ui/search_page.dart';
import 'package:simple_restaurant_app/widget/widget_item_restaurants.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantsProvider>(
      create: (_) => RestaurantsProvider(apiService: ApiService()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Restaurant App',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SearchPage.routeName);
              },
              icon: const Icon(Icons.search),
              key: const Key('search_page_button')
            )
          ],
        ),
        body: Consumer<RestaurantsProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.HasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var restaurant = state.result.restaurants[index];
                  return ItemRestaurants(restaurant: restaurant);
                },
                itemCount: state.result.restaurants.length,
              );
            } else if (state.state == ResultState.NoData) {
              return Center(child: Text(state.message),);
            } else if (state.state == ResultState.Error) {
              return Center(child: Text(state.message),);
            } else {
              return const Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }
}
