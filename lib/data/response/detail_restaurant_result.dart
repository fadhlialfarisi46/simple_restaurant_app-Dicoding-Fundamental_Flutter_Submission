import '../model/restaurant.dart';

class DetailRestaurantResult {
  DetailRestaurantResult({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  bool error;
  String message;
  Restaurant restaurant;

  factory DetailRestaurantResult.fromJson(Map<String, dynamic> json) => DetailRestaurantResult(
    error: json["error"],
    message: json["message"],
    restaurant: Restaurant.fromJson(json["restaurant"]),
  );
}



