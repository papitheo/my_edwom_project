import 'package:edwom/product.dart';
import 'package:flutter/foundation.dart';

class ProductsProvider extends ChangeNotifier {
  late List<Product> _products;

  ProductsProvider() {
    _products = [];
  }

  set setProducts(List<Product> products) {
    _products = products;
    // notifyListeners();
  }

  List<Product> get products => _products;
}
