import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/providers/products.dart';
import 'package:shopApp/screens/edit_product_screen.dart';
import 'package:shopApp/widgets/app_drawer.dart';
import 'package:shopApp/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {

  static const routeName = "/user-products";

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text("Your products"),
      actions: [
        IconButton(
          icon: Icon(Icons.add), onPressed: () {
            Navigator.of(context).pushNamed(EditProductScreen.routeName);
        },
        )
      ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.products.length,
          itemBuilder: (ctx, i) => Column(
            children: [
              UserProductItem(productsData.products[i].id, productsData.products[i].title, productsData.products[i].imageUrl),
              Divider()
            ],
          ),),
      ),
    );
  }
}
