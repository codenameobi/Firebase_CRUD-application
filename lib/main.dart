import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:productapp/core/models/productModel.dart';
import 'package:productapp/core/providers/product_provider.dart';
import 'package:productapp/core/services/firestore_service.dart';
import 'package:productapp/ui/screens/products.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        StreamProvider<List<Product>>.value(
          value: firestoreService.getProducts(),
          initialData: const [],
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Products(),
      ),
    );
  }
}
