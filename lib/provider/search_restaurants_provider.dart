import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:simple_restaurant_app/data/api/api_service.dart';

import '../data/response/search_restaurant_result.dart';
import '../extension/state_management.dart';

class SearchRestaurantProvider extends ChangeNotifier{
  final ApiService apiService;

  SearchRestaurantProvider({required this.apiService}){
    searchRestaurants(query);
  }

  late SearchRestaurantResult _searchrestaurantResult;
  SearchRestaurantResult get result => _searchrestaurantResult;

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  String _query ='';
  String get query => _query;

  Future<dynamic> searchRestaurants(String keyword) async{
    try{
      _state = ResultState.Loading;
      _query = keyword;
      notifyListeners();
      if (keyword.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Try input some keyword';
      }

      final restaurant = await apiService.searchRestaurants(query);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _searchrestaurantResult = restaurant;
      }
    }on SocketException {
      _state = ResultState.Error;
      notifyListeners();
      return _message =
      'No Internet connection. Make sure that Wi-Fi or mobile data is turned on, the try again.';
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}

