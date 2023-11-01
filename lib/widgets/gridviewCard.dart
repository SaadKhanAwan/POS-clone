import 'package:flutter/material.dart';
import 'package:smart_pos_clone/models/icon_Model/icon_model.dart';

class ViewCard extends StatefulWidget {
  final Product product;
  const ViewCard({super.key, required this.product});

  @override
  State<ViewCard> createState() => _ViewCardState();
}

class _ViewCardState extends State<ViewCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
      ),
      child: Card(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: Image.asset(
                widget.product.image,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              widget.product.name,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
