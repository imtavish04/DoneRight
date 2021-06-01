import 'package:flutter/material.dart';
import 'dart:convert'; //to convert data into json format
import 'package:http/http.dart' as http;
import './service_model.dart';

// here we MIX IN this change notifier using the WITH keyword, it is slightly different from inheritance
class Products with ChangeNotifier {
  // private to this function is not directly accessible from outside
  // list is not final bcos it will change
  List<Product> _items = [
    /*  Product(
     id: 'S1',
     title: 'Plumbers',
     description: 'We have to write all about it',
     price: 12,
     imageUrl:
          'https://cdn5.vectorstock.com/i/1000x1000/76/74/tap-icon-vector-1747674.jpg',
    ),
     Product(
     id: 'S2',
     title: 'ELectricians',
     description: 'We have to write all about it',
     price: 20,
     imageUrl:
          'https://cdn3.vectorstock.com/i/1000x1000/91/12/electric-plug-with-power-outlet-flat-icon-vector-20749112.jpg',
    ),
     Product(
     id: 'S3',
     title: 'Painters',
     description: 'We have to write all about it',
     price: 20,
     imageUrl:
          'https://i2.wp.com/files.123freevectors.com/wp-content/uploads/new/objects/502-paint-brush-vector-illustrator.png?w=800&q=95',
    ),
    Product(
     id: 'S4',
     title: 'Carpenters',
     description: 'We have to write all about it',
     price: 20,
     imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTjkLW85BiNLUVeAy5tMxWIw7JKtl9aDz87zw&usqp=CAU',
    ), */
  ];

  //var _showFavouritesOnly = false;
  final String authToken;
  final String userId;
  Products(this.authToken, this.userId, this._items);

// to get a copy of the above items we use a getter
  List<Product> get items {
    // if (_showFavouritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavourite);
    // }

    return [..._items];
  }

  List<Product> get favouriteItems {
    return _items.where((prodItem) => prodItem.isFavourite).toList();
  }
  // void showFavouriesOnly() {
  //   _showFavouritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavouritesOnly =false;
  //   notifyListeners();
  // }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    //optional argument
    final filterString =
        filterByUser ? 'orderBy="createrId"&equalTo="$userId"' : '';
    var url =
        'https://flutter-update-644e3.firebaseio.com/products.json?auth=$authToken&$filterString';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      url =
          'https://flutter-update-644e3.firebaseio.com/userFavourites/$userId.json?auth=$authToken';
      final favouriteResponse = await http.get(url);
      final favouriteData = json.decode(favouriteResponse.body);
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFavourite:
              favouriteData == null ? false : favouriteData[prodId] ?? false,
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
