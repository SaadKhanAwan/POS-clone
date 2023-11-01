import 'package:flutter/material.dart';

class FloactingButton extends StatelessWidget {
  final ontap;
  const FloactingButton({super.key, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: ontap,
      child: const Icon(
        Icons.add,
        size: 40,
      ),
    );
  }
}
