import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_model.dart';

class OrderProvider extends ChangeNotifier {
  List<Cart> _items = [];
  List<Cart> get items => _items;

  // thsi is for save data
  Future saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List cartItem = _items
        .map((itemss) =>
            "${itemss.name},${itemss.price},${itemss.unit},${itemss.weight}")
        .toList();
    await prefs.setStringList('cartItem', List.from(cartItem));
  }

// this is for fetch data
  Future loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List cartItem = prefs.getStringList('cartItem') ?? [];
    _items = cartItem.map((item) {
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
