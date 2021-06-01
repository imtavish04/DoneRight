import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  PhoneNumber number;

  bool
      isFavourite; //it is not final because it will be changable even after creation of product

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavourite = false,
    this.number,
  });

  void _setFavValue(bool newValue) {
    isFavourite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavouriteStatus(String token, String userId) async {
    //OPTIMISTIC UPDATE
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url =
        'https://flutter-update-644e3.firebaseio.com/userFavourites/$userId/$id.json?auth=$token';
    try {
      final response = await http.put(url,
          body: json.encode(
            isFavourite,
          ));
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
