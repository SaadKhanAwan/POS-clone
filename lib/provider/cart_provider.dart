import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_model.dart';

class CartProvider extends ChangeNotifier {
  List<Cart> _items = [];
  List<Cart> get items => _items;

  // thsi is for save data
  Future saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List cartItems = _items
        .map((item) => "${item.name},${item.price},${item.unit},${item.weight}")
        .toList();
    await prefs.setStringList('cartItems', List.from(cartItems));
  }

// this is for fetch data
  Future loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List cartItems = prefs.getStringList('cartItems') ?? [];
    _items = cartItems.map((item) {
      List itemData = item.split(",");
      return Cart(
          name: itemData[0],
          price: int.parse(itemData[1]),
          unit: itemData[2],
          weight: double.parse(itemData[3]));
    }).toList();
  }

  addItem(Cart item) {
    _items.add(item);
    saveData();
    notifyListeners();
  }

  void deleteData(int index) {
    items.removeAt(index);
    saveData();
    notifyListeners();
  }
}
