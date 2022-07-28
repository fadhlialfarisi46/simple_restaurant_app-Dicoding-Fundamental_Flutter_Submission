import 'package:flutter/cupertino.dart';
import 'package:simple_restaurant_app/data/db/db_helper.dart';
import 'package:simple_restaurant_app/data/model/restaurant.dart';
import 'package:simple_restaurant_app/extension/state_management.dart';

class DatabaseProvider extends ChangeNotifier {
  final DbHelper dbHelper;

  DatabaseProvider({required this.dbHelper}) {
    _getFavorites();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  void _getFavorites() async {
    _state = ResultState.loading;
    notifyListeners();

    _favorites = await dbHelper.getFavorites();
    if (_favorites.isNotEmpty) {
      _state = ResultState.hasData;
      notifyListeners();
    } else {
      _state = ResultState.noData;
      _message = "Empty data";
      notifyListeners();
    }
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await dbHelper.insertFavorite(restaurant);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error --> $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoritedRestaurant = await dbHelper.getFavoriteById(id);
    return favoritedRestaurant.isNotEmpty;
  }

  void removeBookmark(String id) async {
    try {
      await dbHelper.deleteFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error --> $e';
      notifyListeners();
    }
  }
}
