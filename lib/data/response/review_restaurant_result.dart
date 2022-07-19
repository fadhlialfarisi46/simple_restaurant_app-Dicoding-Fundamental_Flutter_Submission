import '../model/customer_review.dart';

class ReviewRestaurantResult {
  ReviewRestaurantResult({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  bool error;
  String message;
  List<CustomerReview> customerReviews;

  factory ReviewRestaurantResult.fromJson(Map<String, dynamic> json) => ReviewRestaurantResult(
    error: json["error"],
    message: json["message"],
    customerReviews: List<CustomerReview>.from(json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
  );

}