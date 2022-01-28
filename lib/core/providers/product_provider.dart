// ignore_for_file: unused_local_variable

import 'package:flutter/widgets.dart';
import 'package:productapp/core/models/productModel.dart';
import 'package:productapp/core/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class ProductProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _name;
  double _unit;
  String _productId;
  var uuid = const Uuid();

  //Getters
  String get name => _name;
  double get unit => _unit;

  //Setters
  changeName(String value) {
    _name = value;
    notifyListeners();
  }

  changePrice(String value) {
    _unit = double.parse(value);
    notifyListeners();
  }

  loadValues(Product product) {
    _name = product.name;
    _unit = product.unit;
    _productId = product.productId;
  }

  saveProduct() {
    print(_productId);
    if (_productId == null) {
      var newProduct = Product(name: name, unit: unit, productId: uuid.v4());
      firestoreService.saveProduct(newProduct);
    } else {
      var updatedProduct =
          Product(name: name, unit: _unit, productId: _productId);
      firestoreService.saveProduct(updatedProduct)
    }
  }

  removeProduct(String productId) {
    firestoreService.removeProduct(productId);
  }
}
