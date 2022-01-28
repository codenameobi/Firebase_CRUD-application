class Product {
  final String productId;
  final double unit;
  final String name;

  Product({required this.productId, required this.unit, required this.name});

  // ignore: empty_constructor_bodies
  Map<String, dynamic> toMap() {
    return {'productId': productId, 'name': name, 'unit': unit};
  }

  Product.fromFirestore(Map firestore)
      : productId = firestore['productId'],
        name = firestore['name'],
        unit = firestore['unit'];
}
