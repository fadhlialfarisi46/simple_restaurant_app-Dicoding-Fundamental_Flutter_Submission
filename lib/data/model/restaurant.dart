import 'dart:convert';

class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  Menus menus;

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
        menus: Menus.fromJson(json["menus"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
        "menus": menus.toJson(),
      };
}

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });

  List<NameMenu> foods;
  List<NameMenu> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<NameMenu>.from(json["foods"].map((x) => NameMenu.fromJson(x))),
        drinks: List<NameMenu>.from(json["drinks"].map((x) => NameMenu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}

class NameMenu {
  NameMenu({
    required this.name,
  });

  String name;

  factory NameMenu.fromJson(Map<String, dynamic> json) => NameMenu(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

List<Restaurant> parseRestos(String json) {
  final List parsed = jsonDecode(json)["restaurants"];

  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}
