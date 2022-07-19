import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:simple_restaurant_app/data/api/api_service.dart';
import 'package:simple_restaurant_app/extension/state_management.dart';

import '../data/response/restaurant_result.dart';

class RestaurantsProvider extends ChangeNotifier{
  final ApiService apiService;

  RestaurantsProvider({required this.apiService}){
    _fetchAllRestaurant();
  }

  late RestaurantResult _restaurantResult;
  RestaurantResult get result => _restaurantResult;

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  Future<dynamic> _fetchAllRestaurant() async {
    try{
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.listRestaurants();
      if(restaurant.restaurants.isEmpty){
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      }else{
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    }on SocketException{
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'No internet connection. Make sure your Wi-Fi or mobile data is turned on, then try again.';
    }catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}

