import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final validator;
  double height = 20;
  var Fieldcontroller;
  var type;
  var change;
  var val;
  var ontab;

  String? name = "Search Here...";
  CustomTextField(
      {super.key,
      this.Fieldcontroller,
      this.ontab,
      required this.height,
      this.type,
      this.validator,
      this.val,
      this.change,
      this.name});

  @override
  Widget build(BuildContext context) {
    // height = EdgeInsets.symmetric();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: type,
        textAlign: TextAlign.start,
        controller: Fieldcontroller,
        initialValue: val,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: height),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 3, color: Colors.purple.shade800),
            ),
            hintText: name,
            hintStyle: const TextStyle(fontSize: 20, color: Colors.grey)),
        validator: validator,
        onChanged: change,
        onTap: ontab,
      ),
    );
  }
}
