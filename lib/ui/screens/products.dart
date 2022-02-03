import 'package:flutter/material.dart';
import 'package:productapp/core/models/productModel.dart';
import 'package:productapp/ui/screens/edit_product.dart';

import 'package:provider/provider.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.add,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const EditProduct()));
              },
            )
          ],
        ),
        body: Builder(builder: (BuildContext context) {
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 0.5, color: Colors.grey)),
                child: ListTile(
                  title: Text(products[index].name!),
                  trailing: Text(products[index].unit.toString()),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => EditProduct(
                              products[index],
                            )));
                  },
                ),
              );
            },
          );
        }));
  }
}
