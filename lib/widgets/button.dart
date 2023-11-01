import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Button extends StatelessWidget {
  var ontap;
  String name;
  Button({super.key, required this.ontap, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: ElevatedButton(
        onPressed: ontap,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple.shade800,
            minimumSize: const Size(300, 50)),
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
