import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:smart_pos_clone/provider/orderprovider.dart';

// ignore: must_be_immutable
class OrderScreen extends StatefulWidget {
  String? name;
  int? price;
  OrderScreen({super.key, this.name, this.price});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final searcheditingcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          title: const Text(
            "Order History",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Colors.purple.shade800,
        ),
        body: _buildOrderScreen());
  }

  _buildOrderScreen() {
    final orderProvider = Provider.of<OrderProvider>(context, listen: true);
    return FutureBuilder(
        future: orderProvider.loadData(),
        builder: (context, snapshort) {
          if (orderProvider.items.isEmpty) {
            return const Center(
              child: Text(
                'Order is empty',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            );
          }
          return ListView.builder(
              itemCount: orderProvider.items.length,
              itemBuilder: (context, index) {
                final cartItem = orderProvider.items[index];
                return Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          orderProvider.deleteData(index);
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
                    padding:
                        const EdgeInsets.only(left: 5.0, right: 5.0, top: 5),
                    child: Card(
                      child: ListTile(
                        title: Text(
                          cartItem.name ?? '',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$${cartItem.price ?? ''}',
                              style: const TextStyle(fontSize: 17),
                            ),
                            Text(
                              '${cartItem.unit ?? ''}',
                              style: const TextStyle(fontSize: 17),
                            ),
                            Text(
                              '\$${cartItem.weight ?? ''}',
                              style: const TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                        trailing: const Column(
                          children: [
                            Icon(
                              Icons.gpp_good_outlined,
                              color: Colors.green,
                              size: 40,
                            ),
                            Text(
                              "Order Added Successfully",
                              style: TextStyle(color: Colors.green),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
