import 'package:flutter/material.dart';
import 'package:flutter_project/models/Product.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => _items;

  void addProduct(Product p) {
    _items.add(p);
    notifyListeners();
  }

  void removeProduct(Product p) {
    _items.remove(p);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }

  void updateQuantity(String id, int newQuantity) {
    final index = _items.indexWhere((product) => product.id == id);
    if (index != -1) {
      _items[index].cartChangeQuantity = newQuantity;
      notifyListeners();
    }
  }

  double getTotal() {
    double total = 0;
    for (final item in _items) {
      total += item.price * item.quantity;
    }
    return total;
  }
}
