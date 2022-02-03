import 'package:flutter/material.dart';
import 'package:productapp/core/models/productModel.dart';
import 'package:provider/provider.dart';
import 'package:productapp/core/providers/product_provider.dart';

class EditProduct extends StatefulWidget {
  final Product? product;

  const EditProduct([this.product]);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final nameController = TextEditingController();
  final unitController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    unitController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.product == null) {
      //New Record
      nameController.text = "";
      unitController.text = "";
      Future.delayed(Duration.zero, () {
        final productProvider =
            Provider.of<ProductProvider>(context, listen: false);
        productProvider.loadValues(Product());
      });
    } else {
      nameController.text = widget.product!.name!;
      unitController.text = widget.product!.unit!.toString();

      Future.delayed(Duration.zero, () {
        final productProvider =
            Provider.of<ProductProvider>(context, listen: false);
        productProvider.loadValues(widget.product!);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
        appBar: AppBar(title: Text('Edit Product')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              TextField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: 'Product Name'),
                  onChanged: (value) {
                    productProvider.changeName(value);
                  }),
              TextField(
                  controller: unitController,
                  decoration: const InputDecoration(hintText: 'Product Unit'),
                  onChanged: (value) {
                    productProvider.changeUnit(value);
                  }),
              const SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                child: const Text('Save'),
                onPressed: () {
                  productProvider.saveProduct();
                  Navigator.of(context).pop();
                },
              ),
              (widget.product != null)
                  ? RaisedButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      child: const Text('Delete'),
                      onPressed: () {
                        productProvider
                            .removeProduct(widget.product!.productId!);
                        Navigator.of(context).pop();
                      },
                    )
                  : Container(),
            ],
          ),
        ));
  }
}
