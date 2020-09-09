import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/providers/cart.dart' show Cart;
import 'package:shopApp/providers/orders.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {

  static const routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    final cart  = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart")
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total", style: TextStyle(fontSize: 20)),
                Spacer(),
                Chip(label: Text('${cart.totalAmount.toStringAsFixed(2)}\$')),
                FlatButton(
                  child: Text("ORDER NOW"),
                  onPressed: (){
                    Provider.of<Orders>(context, listen: false).addOrder(cart.items.values.toList(), cart.totalAmount);
                    cart.clear();
                  },
                  textColor: Theme.of(context).accentColor,
                )
              ],
            )
          ),
          SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (ctx, i) => CartItem(cart.items.values.toList()[i].id, cart.items.values.toList()[i].price, cart.items.values.toList()[i].quantity, cart.items.values.toList()[i].title, cart.items.keys.toList()[i]),
            ),
          )
        ],
      )
    );
  }
}
