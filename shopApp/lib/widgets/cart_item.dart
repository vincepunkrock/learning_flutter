import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/providers/cart.dart';

class CartItem extends StatelessWidget {

  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem(this.id, this.price, this.quantity, this.title, this.productId);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(Icons.delete, color: Colors.white, size: 40,),
        alignment: Alignment.centerRight,
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(context: context, builder: (ctx) => AlertDialog(
          title: Text("Are you sure?"),
        content: Text("Do you want to remove the item from the cart?"),
        actions: [
          FlatButton(child: Text("Yes"), onPressed: (){Navigator.of(ctx).pop(true);},),
          FlatButton(child: Text("No"), onPressed: (){Navigator.of(ctx).pop(false);}),
        ],
        ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4
        ),
      child: ListTile(
        leading: CircleAvatar(child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: FittedBox(child: Text('$price\$'),),
        )),
        title: Text(title),
        subtitle: Text("Quantity: $quantity"),
        trailing: Text("Total: ${price * quantity}\$"),
      ),
    )
    );
  }
}
