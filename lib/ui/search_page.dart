import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_restaurant_app/data/api/api_service.dart';
import 'package:simple_restaurant_app/extension/state_management.dart';
import 'package:simple_restaurant_app/provider/search_restaurants_provider.dart';
import 'package:simple_restaurant_app/widget/widget_item_restaurants.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String lastInputText='';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=> SearchRestaurantProvider(apiService: ApiService()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Search Restaurants',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
        ),
        body: SafeArea(
          child: Column(
            children: [_buildSearchField(), Expanded(child: _buildListRestaurant())],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<SearchRestaurantProvider>(
        builder: (context, state, _) {
          return TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Input text here',
              prefixIcon: Icon(Icons.search_sharp, color: Colors.black)
            ),
            onChanged: (keyword) async {
               if (keyword.trim().isNotEmpty && lastInputText != keyword) {
                lastInputText = keyword;
                  await state.searchRestaurants(keyword);
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildListRestaurant() {
    return Consumer<SearchRestaurantProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.Loading){
            return const Center(child: CircularProgressIndicator());
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
    });
  }
}
