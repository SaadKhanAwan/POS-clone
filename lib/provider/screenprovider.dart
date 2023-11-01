import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Screenchangeprovider extends ChangeNotifier {
  int _current_index = 0;
  int get counter => _current_index;

  ChangeScreen(value) {
    _current_index = value;
    notifyListeners();
  }

  static Screenchangeprovider of(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<Screenchangeprovider>(context, listen: listen);
  }
}
