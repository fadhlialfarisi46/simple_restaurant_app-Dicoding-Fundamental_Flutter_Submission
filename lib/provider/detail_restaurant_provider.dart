import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:simple_restaurant_app/data/model/customer_review.dart';
import 'package:simple_restaurant_app/data/response/detail_restaurant_result.dart';
import 'package:simple_restaurant_app/data/response/review_restaurant_result.dart';

import '../data/api/api_service.dart';
import '../extension/state_management.dart';

class DetailRestaurantsProvider extends ChangeNotifier{
  final ApiService apiService;
  final String id;

  DetailRestaurantsProvider({required this.apiService, required this.id}){
    _fetchDetailRestaurant(id);
  }

  late DetailRestaurantResult _restaurantResult;
  DetailRestaurantResult get result => _restaurantResult;

  late ReviewRestaurantResult _reviewRestaurantResult;
  ReviewRestaurantResult get reviewResult => _reviewRestaurantResult;

  late ResultState _state;
  ResultState get state => _state;

  late PostState _postState;
  PostState get postState => _postState;

  String _message = '';
  String get message => _message;

  String _postMessage = '';
  String get postMessage => _postMessage;

  final List<CustomerReview> _customerReview = [];
  List<CustomerReview> get customerReview => _customerReview;

  Future<dynamic> _fetchDetailRestaurant(String id) async {
    try{
      _state = ResultState.Loading;
      notifyListeners();

      final restaurant = await apiService.detailRestaurants(id);
      if(restaurant.error){
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Failed to load data';
      }else{
        _state = ResultState.HasData;
        restaurant.restaurant.customerReviews?.forEach((element) {
          _customerReview.add(element);
        });
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

  Future<dynamic> postReview(String id, String name, String review) async{
    try{
      _postState = PostState.Loading;

      final result = await apiService.postReview(id, name, review);
      notifyListeners();
      if(result.error){
        _postState = PostState.Error;
        notifyListeners();
        return _postMessage = 'Error: ${result.message}';
      }else{
        _postState = PostState.Success;
        _customerReview.length = 0;
        for (var element in result.customerReviews) {
          _customerReview.add(element);
        }
        notifyListeners();
        return _reviewRestaurantResult = result;
      }
    } on SocketException{
      _postState = PostState.Error;
      notifyListeners();
      return _postMessage = 'No internet connection. Make sure your Wi-Fi or mobile data is turned on, then try again.';
    }catch (e) {
      _postState = PostState.Error;
      notifyListeners();
      return _postMessage = 'Error --> $e';
    }
  }
}
