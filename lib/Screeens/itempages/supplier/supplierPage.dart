import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_pos_clone/Screeens/itempages/supplier/add%20suppliers.dart';
import 'package:smart_pos_clone/widgets/floatingbutton.dart';
import 'package:smart_pos_clone/widgets/textfield.dart';

import 'Editsupplier.dart';

class SupplierPage extends StatefulWidget {
  const SupplierPage({super.key});

  @override
  State<SupplierPage> createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {
  final searcheditingcontroller = TextEditingController();
  final ref = FirebaseDatabase.instance.ref("Suppliers");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          "All Suppliers",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.purple.shade800,
      ),
      body: _buildSupplierScreen(),
      floatingActionButton: FloactingButton(
        ontap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddSupplier()));
        },
      ),
    );
  }

  _buildSupplierScreen() {
    return Column(
      children: [
        CustomTextField(
          name: "Search Here...",
          height: 20,
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
                          final title = list[index]['supplier name'];
                          if (searcheditingcontroller.text.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, right: 5, left: 5),
                              child: Card(
                                child: ListTile(
                                  leading: Icon(
                                    Icons.card_travel,
                                    size: 70,
                                    color: Colors.purple.shade800,
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        list[index]['supplier name'].toString(),
                                      ),
                                      Text(list[index]
                                              ['supplier contact person']
                                          .toString()),
                                      Text(list[index]['Supplier cell']
                                          .toString()),
                                      Text(list[index]['Supplier email']
                                          .toString()),
                                      Text(list[index]['Supplier address']
                                          .toString())
                                    ],
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => EditSupplier(
                                                      name: title.toString(),
                                                      contact: list[index][
                                                              'supplier contact person']
                                                          .toString(),
                                                      cell: list[index]
                                                              ['Supplier cell']
                                                          .toString(),
                                                      email: list[index]
                                                              ['Supplier email']
                                                          .toString(),
                                                      id: list[index]['id']
                                                          .toString(),
                                                      adress: list[index][
                                                              'Supplier address']
                                                          .toString())));
                                        },
                                        child: const Icon(
                                          Icons.edit,
                                          size: 25,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          var id = list[index]['id'].toString();
                                          ref.child(id).remove();
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          size: 25,
                                        ),
                                      ),
                                    ],
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
                                  leading: Icon(
                                    Icons.card_travel,
                                    size: 70,
                                    color: Colors.purple.shade800,
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        list[index]['supplier name'].toString(),
                                      ),
                                      Text(list[index]
                                              ['supplier contact person']
                                          .toString()),
                                      Text(list[index]['Supplier cell']
                                          .toString()),
                                      Text(list[index]['Supplier email']
                                          .toString()),
                                      Text(list[index]['Supplier address']
                                          .toString())
                                    ],
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.edit,
                                          size: 25,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.delete,
                                          size: 25,
                                        ),
                                      ),
                                    ],
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
