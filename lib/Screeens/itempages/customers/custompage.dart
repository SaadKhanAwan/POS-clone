import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_pos_clone/Screeens/itempages/customers/addcustomer.dart';
import 'package:smart_pos_clone/Screeens/itempages/customers/editcustomer.dart';
// import 'package:smart_pos_clone/firebase_services/realtimedatabase/databa_customer.dart';
import 'package:smart_pos_clone/widgets/textfield.dart';
import '../../../widgets/floatingbutton.dart';

class CustomPage extends StatefulWidget {
  const CustomPage({super.key});

  @override
  State<CustomPage> createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> {
  final ref = FirebaseDatabase.instance.ref("customers");
  // AddCustomersFire addit = AddCustomersFire();
  final searcheditingcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("All Customers",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        backgroundColor: Colors.purple.shade800,
      ),
      body: _buildCustomerScreen(),
      floatingActionButton: FloactingButton(
        ontap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddCustomer()));
        },
      ),
    );
  }

  _buildCustomerScreen() {
    return Column(
      children: <Widget>[
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
                          final title = list[index]['name'];
                          if (searcheditingcontroller.text.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 8, right: 8),
                              child: Card(
                                child: ListTile(
                                  leading: Icon(
                                    Icons.people_alt,
                                    size: 70,
                                    color: Colors.purple.shade800,
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        list[index]['name'].toString(),
                                      ),
                                      Text(list[index]['cell'].toString()),
                                      Text(list[index]['email'].toString()),
                                      Text(list[index]['address'].toString())
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
                                                  builder: (context) =>
                                                      EditCustomer(
                                                        name: title.toString(),
                                                        cell: list[index]
                                                                ['cell']
                                                            .toString(),
                                                        email: list[index]
                                                                ['email']
                                                            .toString(),
                                                        address: list[index]
                                                                ['address']
                                                            .toString(),
                                                        id: list[index]['id']
                                                            .toString(),
                                                      )));
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
                                  top: 8.0, left: 8, right: 8),
                              child: Card(
                                child: ListTile(
                                  leading: Icon(
                                    Icons.people_alt,
                                    size: 70,
                                    color: Colors.purple.shade800,
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(list[index]['name'].toString()),
                                      Text(list[index]['cell'].toString()),
                                      Text(list[index]['email'].toString()),
                                      Text(list[index]['address'].toString())
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
