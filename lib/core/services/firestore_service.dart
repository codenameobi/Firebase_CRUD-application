import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productapp/core/models/productModel.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future saveProduct(Product product) {
    return _db
        .collection('products')
        .doc(product.productId)
        .set(product.toMap());
  }

  Stream<List<Product>> getProducts() {
    return _db.collection('products').snapshots().map((snapshot) => snapshot
        .docs
        .map((document) => Product.fromFirestore(document.data()))
        .toList());
  }

  Future removeProduct(String productId) {
    return _db.collection('product').doc(productId).delete();
  }
}
