// ignore_for_file: unused_local_variable
// The ProductProvider class acts as the bridge between our UI and our service.
//The private variables in the class store variable state until we are ready to submit our values to the database.
//Getters and Setters allow for public access to the variables from the UI.
//Although we will not listen to changes in this project, the ChangeNotifier mixin and the notifyListeners() calls on each setter, when combined with Provider, allow the UI to listen to and respond to value changes.
//The loadValues function is there to keep our state consistent with our UI (more on this later), and the saveProduct and removeProduct functions allow the UI to call database changes without needing to import the service. In this class, saveProduct does the work of both an insert and an update by checking for the existance of a value in the private _productId variable. If no id exists, one is created with the UUID package and passed to the service.
import 'package:flutter/widgets.dart';
import 'package:productapp/core/models/productModel.dart';
import 'package:productapp/core/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class ProductProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String? _name;
  double? _unit;
  String? _productId;
  var uuid = const Uuid();

  //Getters
  String? get name => _name;
  double? get unit => _unit;

  //Setters
  changeName(String value) {
    _name = value;
    notifyListeners();
  }

  changeUnit(String value) {
    _unit = double.parse(value);
    notifyListeners();
  }

  loadValues(Product product) {
    _name = product.name!;
    _unit = product.unit!;
    _productId = product.productId!;
  }

  saveProduct() {
    print(_productId);
    if (_productId == null) {
      var newProduct = Product(name: name, unit: unit, productId: uuid.v4());
      firestoreService.saveProduct(newProduct);
    } else {
      var updatedProduct =
          Product(name: name, unit: _unit, productId: _productId);
      firestoreService.saveProduct(updatedProduct);
    }
  }

  removeProduct(String productId) {
    firestoreService.removeProduct(productId);
  }
}
