import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:simple_restaurant_app/data/response/detail_restaurant_result.dart';
import 'package:simple_restaurant_app/data/response/review_restaurant_result.dart';
import 'package:simple_restaurant_app/data/response/search_restaurant_result.dart';

import '../response/restaurant_result.dart';

class ApiService {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev';

  String get urlSmallImage => baseUrl + '/images/small/';

  String get urlLargeImage => baseUrl + '/images/large/';

  Client? client;
  ApiService({this.client}) {
    client ??= Client();
  }

  Future<RestaurantResult> listRestaurants() async {
    final response = await client!.get(Uri.parse(baseUrl + '/list'));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Restaurants');
    }
  }

  Future<DetailRestaurantResult> detailRestaurants(String id) async {
    final response = await client!.get(Uri.parse(baseUrl + '/detail/' + id));
    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail Restaurant');
    }
  }

  Future<SearchRestaurantResult> searchRestaurants(String keyword) async {
    final response =
        await client!.get(Uri.parse(baseUrl + '/search?q=' + keyword));
    if (response.statusCode == 200) {
      return SearchRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to search Restaurant');
    }
  }

  Future<ReviewRestaurantResult> postReview(
      String id, String name, String review) async {
    final response = await client!.post(Uri.parse(baseUrl + '/review'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': id, 'name': name, 'review': review}));
    if (response.statusCode == 201) {
      return ReviewRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add review');
    }
  }
}
