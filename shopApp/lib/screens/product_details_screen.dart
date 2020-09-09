import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/providers/products.dart';

class ProductDetailsScreen extends StatelessWidget {

//  final Product product;
//
//  ProductDetailsScreen(this.product);

  static const routeName = "/product-details";

  @override
  Widget build(BuildContext context) {

    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(context, listen: false).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title)
      ),
    );
  }
}
