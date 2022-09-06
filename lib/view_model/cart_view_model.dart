
import 'package:flutter/material.dart';

import '../product.dart';

class BagViewModel extends ChangeNotifier {

BagViewModel() : productsBag = [];

final List<Product> productsBag;


void addProduct(Product product) {
    productsBag.add(product);
    notifyListeners();
}


void clearBag() {
    productsBag.clear();
    notifyListeners();
  }


}
