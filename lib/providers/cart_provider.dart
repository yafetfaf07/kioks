import 'package:flutter/widgets.dart';
import 'package:flutter_project/models/Product.dart';

class CartProvider extends ChangeNotifier {

  final List<Product> _items=[];

  List<Product> get items => _items;

  void addProduct(Product p) {
    _items.add(p);
    notifyListeners();
  }

  void removeProduct (Product p) {
    _items.remove(p);
    notifyListeners();
  }
  void removeAll () {
    _items.clear();
  notifyListeners();
  }

  double getTotal () {
    double total=0;
    for(int i=0; i<_items.length; i++) {
      total+=items[i].price;
    }
    return total;
  }

}