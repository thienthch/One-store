import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static const String favoriteKeyPrefix = 'favorite_';

  static Future<void> saveFavoriteStatus(
      String productId, bool isFavorite) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_getFavoriteKey(productId), isFavorite);
  }

  static Future<bool> loadFavoriteStatus(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_getFavoriteKey(productId)) ?? false;
  }

  static String _getFavoriteKey(String productId) {
    return '$favoriteKeyPrefix$productId';
  }
}
