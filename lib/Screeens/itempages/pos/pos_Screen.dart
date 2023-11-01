import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_pos_clone/Screeens/itempages/pos/Cart_screen.dart';
import 'package:smart_pos_clone/models/cart_model.dart';
import 'package:smart_pos_clone/widgets/button.dart';
import 'package:smart_pos_clone/widgets/textfield.dart';

import '../../../provider/cart_provider.dart';

class POS_Screen extends StatefulWidget {
  const POS_Screen({super.key});

  @override
  State<POS_Screen> createState() => _POS_ScreenState();
}

class _POS_ScreenState extends State<POS_Screen> {
  final searcheditingcontroller = TextEditingController();
  final ref = FirebaseDatabase.instance.ref('Products');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          title: const Text(
            "All POS Products",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Colors.purple.shade800,
          actions: [
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CartScreen()));
              },
              child: const Icon(
                Icons.shopping_cart,
                color: Colors.orange,
              ),
            )
          ],
        ),
        body: _buildPOSScreen());
  }

  _buildPOSScreen() {
    return Column(
      children: [
        CustomTextField(
          height: 20,
          name: "Search Here....",
          Fieldcontroller: searcheditingcontroller,
          change: (String value) {
            setState(() {});
          },
        ),
        Expanded(
            child: StreamBuilder(
                stream: ref.onValue,
                builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                  if (snapshot.hasData) {
                    Map<dynamic, dynamic> map =
                        snapshot.data!.snapshot.value as dynamic;
                    List<dynamic> list = [];
                    list.clear();
                    list = map.values.toList();
                    return GridView.builder(
                        itemCount: snapshot.data!.snapshot.children.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                                childAspectRatio: 10 / 13),
                        itemBuilder: (context, index) {
                          final title = list[index]['name'];
                          if (searcheditingcontroller.text.isEmpty) {
                            return Card(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.photo,
                                  size: 70,
                                  color: Colors.purple.shade800,
                                ),
                                Text(
                                  list[index]['name'].toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(list[index]['Product weigth']
                                        .toString()),
                                    Text(
                                        " ${list[index]['Product weigth unit'].toString()}"),
                                  ],
                                ),
                                Text(
                                    "\$${list[index]['Product Sell price'].toString()}"),
                                Button(
                                    ontap: () async {
                                      final cartProvider =
                                          Provider.of<CartProvider>(context,
                                              listen: false);
                                      cartProvider.addItem(Cart(
                                          name: list[index]['name'].toString(),
                                          weight: double.parse(list[index]
                                                  ['Product weigth']
                                              .toString()),
                                          unit: list[index]
                                                  ['Product weigth unit']
                                              .toString(),
                                          price: int.parse(list[index]
                                                  ['Product Sell price']
                                              .toString())));
                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CartScreen()));
                                    },
                                    name: "ADD TO CART")
                              ],
                            ));
                          } else if (title.toLowerCase().contains(
                              searcheditingcontroller.text
                                  .toLowerCase()
                                  .toString())) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Card(
                                  child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.photo,
                                    size: 70,
                                    color: Colors.purple.shade800,
                                  ),
                                  Text(
                                    list[index]['name'].toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(list[index]['Product weigth']
                                          .toString()),
                                      Text(
                                          " ${list[index]['Product weigth unit'].toString()}"),
                                    ],
                                  ),
                                  Text(
                                      "\$${list[index]['Product Sell price'].toString()}"),
                                  Button(
                                      ontap: () {
                                        final cartProvider =
                                            Provider.of<CartProvider>(context,
                                                listen: false);
                                        cartProvider.addItem(Cart(
                                            name:
                                                list[index]['name'].toString(),
                                            weight: double.parse(list[index]
                                                    ['Product weigth']
                                                .toString()),
                                            unit: list[index]
                                                    ['Product weigth unit']
                                                .toString(),
                                            price: int.parse(list[index]
                                                    ['Product Sell price']
                                                .toString())));
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const CartScreen()));
                                      },
                                      name: "ADD TO CART")
                                ],
                              )),
                            );
                          }
                          return null;
                        });
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }))
      ],
    );
  }
}
