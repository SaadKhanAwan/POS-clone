import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:smart_pos_clone/Screeens/itempages/all%20order/Order_Screen.dart';

import '../../../models/cart_model.dart';
import '../../../provider/cart_provider.dart';
import '../../../provider/orderprovider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.purple.shade700,
          centerTitle: true,
          title: const Text(
            "Product Cart",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: _buildCartitems());
  }

  _buildCartitems() {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    return FutureBuilder(
        future: cartProvider.loadData(),
        builder: (context, snapshot) {
          if (cartProvider.items.isEmpty) {
            return const Center(
              child: Text(
                'Cart is empty',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            );
          }
          return ListView.builder(
            itemCount: cartProvider.items.length,
            itemBuilder: (context, index) {
              final cartItem = cartProvider.items[index];
              return Slidable(
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        cartProvider.deleteData(index);
                        setState(() {});
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: "Delete",
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8),
                  child: Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.photo,
                        size: 70,
                        color: Colors.purple.shade800,
                      ),
                      title: Text(cartItem.name ?? '',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$${cartItem.price ?? ''}',
                            style: const TextStyle(fontSize: 17),
                          ),
                          Text(
                            '\$${cartItem.unit ?? ''}',
                            style: const TextStyle(fontSize: 17),
                          ),
                          Text(
                            '${cartItem.weight ?? ''}',
                            style: const TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          final orderProvider = Provider.of<OrderProvider>(
                              context,
                              listen: false);
                          orderProvider.addItem(Cart(
                              name: cartItem.name.toString(),
                              weight: double.parse(cartItem.weight.toString()),
                              unit: cartItem.unit.toString(),
                              price: int.parse(cartItem.price.toString())));
                          cartProvider.deleteData(index);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderScreen()));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.send,
                              color: Colors.purple.shade700,
                            ),
                            Text(
                              "Order IT",
                              style: TextStyle(
                                  color: Colors.purple.shade700,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
