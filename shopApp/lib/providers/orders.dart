import 'package:flutter/foundation.dart';
import './cart.dart' show CartItem;

class Order {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  Order({
    this.id,
    this.amount,
    this.products,
    this.dateTime
  });
}

class Orders with ChangeNotifier {

  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }
  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(0, Order(id: DateTime.now().toString(), amount: total, products: cartProducts, dateTime: DateTime.now()));
    notifyListeners();
  }

}