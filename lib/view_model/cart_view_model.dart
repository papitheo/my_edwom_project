import 'package:flutter/material.dart';

import '../product.dart';

class BagViewModel extends ChangeNotifier {
  BagViewModel() : productsBag = [];

  final List<Product> productsBag;

  void addProduct(Product product) {
    productsBag.add(product);
    notifyListeners();
  }
  void removeProduct(Product product) {
    productsBag.remove(product);
    notifyListeners();
  }

  void clearBag() {
    productsBag.clear();
    notifyListeners();
  }

    void deleteBag() {
    productsBag.clear();
    notifyListeners();
  }

  int get totalProducts => productsBag.length;

  double get totalPrice => productsBag.fold(0, (total, product) {
        return total + product.price;
      });

  bool get isBagEmpty => productsBag.isEmpty;
}
