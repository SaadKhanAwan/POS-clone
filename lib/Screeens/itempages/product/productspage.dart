import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_pos_clone/Screeens/itempages/product/add%20product.dart';
import 'package:smart_pos_clone/widgets/floatingbutton.dart';
import 'package:smart_pos_clone/widgets/textfield.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final searcheditingcontroller = TextEditingController();
  final ref = FirebaseDatabase.instance.ref('Products');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          "All Products",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.purple.shade800,
      ),
      body: _buildProductScreen(),
      floatingActionButton: FloactingButton(
        ontap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddProduct()));
        },
      ),
    );
  }

  _buildProductScreen() {
    return Column(
      children: [
        CustomTextField(
          height: 20,
          name: "search Here...",
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
                    return ListView.builder(
                        itemCount: snapshot.data!.snapshot.children.length,
                        itemBuilder: (context, index) {
                          final title = list[index]['name'];
                          final url = list[index]['image_url'] ?? "";
                          print(url);
                          if (searcheditingcontroller.text.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 5, right: 5),
                              child: Card(
                                child: ListTile(
                                  leading: url.isNotEmpty
                                      ? CircleAvatar(
                                          maxRadius: 30,
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: Image.network(
                                              url,
                                              height: 90,
                                              fit: BoxFit.cover,
                                              width: 20,
                                            ),
                                          ))
                                      : Icon(
                                          Icons.photo,
                                          size: 70,
                                          color: Colors.purple.shade800,
                                        ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(list[index]['name'].toString()),
                                      Text(
                                        "Supplier: ${list[index]['Product Supplier'].toString()}",
                                        style:
                                            const TextStyle(color: Colors.red),
                                      ),
                                      Text(
                                          "Buy Price: \$${list[index]['Product Buy price'].toString()}",
                                          style: const TextStyle(
                                              color: Colors.red)),
                                      Text(
                                          "Sell Price: \$${list[index]['Product Sell price'].toString()}",
                                          style: const TextStyle(
                                              color: Colors.red)),
                                    ],
                                  ),
                                  trailing: GestureDetector(
                                    onTap: () {
                                      var id = list[index]['id'].toString();
                                      ref.child(id).remove();
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 44,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else if (title.toLowerCase().contains(
                              searcheditingcontroller.text
                                  .toLowerCase()
                                  .toString())) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, right: 5, left: 5),
                              child: Card(
                                child: ListTile(
                                  leading: url.isNotEmpty
                                      ? CircleAvatar(
                                          minRadius: 120,
                                          child: Image.network(url,
                                              fit: BoxFit.cover))
                                      : Icon(
                                          Icons.photo,
                                          size: 70,
                                          color: Colors.purple.shade800,
                                        ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(list[index]['name'].toString()),
                                      Text(
                                        "Supplier: ${list[index]['Product Supplier'].toString()}",
                                        style:
                                            const TextStyle(color: Colors.red),
                                      ),
                                      Text(
                                          "Buy Price: ${list[index]['Product Buy price'].toString()}",
                                          style: const TextStyle(
                                              color: Colors.red)),
                                      Text(
                                          "Sell Price: ${list[index]['Product Sell price'].toString()}",
                                          style: const TextStyle(
                                              color: Colors.red))
                                    ],
                                  ),
                                  trailing: GestureDetector(
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.delete,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ),
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
