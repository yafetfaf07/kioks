import 'package:flutter/material.dart';
import 'package:flutter_project/models/Product.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => _items;

  bool addProduct(Product p) {
    final exists = _items.any((item) => item.id == p.id);
    if (!exists) {
      _items.add(p);
      notifyListeners();
      return true;
    }
    return false;
  }

  void removeProduct(Product p) {
    _items.removeWhere((item) => item.id == p.id);
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

  bool isInCart(String id) {
    return _items.any((item) => item.id == id);
  }
}