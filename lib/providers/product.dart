import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavStatus(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  void toggleFavoriteStatus(String token, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        'https://shopapp-bb57b-default-rtdb.firebaseio.com/userFavroties/$userId/$id.json?auth=$token';
    try {
      final response = await http.put(url,
          body: json.encode(
            isFavorite,
          ));
      if (response.statusCode >= 400) {
        _setFavStatus(oldStatus);
      }
    } catch (error) {
      isFavorite = oldStatus;
      notifyListeners();
    }
  }
}
