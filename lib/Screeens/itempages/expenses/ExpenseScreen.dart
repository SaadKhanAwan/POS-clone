import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_pos_clone/Screeens/itempages/expenses/add%20expense.dart';
import 'package:smart_pos_clone/widgets/textfield.dart';
import '../../../widgets/floatingbutton.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final searcheditingcontroller = TextEditingController();
  final ref = FirebaseDatabase.instance.ref('Expenses');
  final id = DateTime.now().microsecondsSinceEpoch.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          "All Expense",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.purple.shade800,
      ),
      body: _buildExpenseScreen(),
      floatingActionButton: FloactingButton(
        ontap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddExpense()));
        },
      ),
    );
  }

  _buildExpenseScreen() {
    return Column(
      children: [
        CustomTextField(
          name: "Search Here...",
          height: 20,
          Fieldcontroller: searcheditingcontroller,
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
                          final title = list[index]['Expense name'];
                          if (searcheditingcontroller.text.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Card(
                                child: ListTile(
                                  leading: Icon(
                                    Icons.monetization_on,
                                    size: 70,
                                    color: Colors.purple.shade800,
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(list[index]['Expense name']
                                          .toString()),
                                      Text(
                                        "Amount: \$${list[index]['Expense amount'].toString()}",
                                        style:
                                            const TextStyle(color: Colors.red),
                                      ),
                                      Text(
                                          "Date: ${list[index]['Date'].toString()}",
                                          style: const TextStyle(
                                              color: Colors.red)),
                                      Text(
                                          "Time: ${list[index]['time'].toString()}",
                                          style: const TextStyle(
                                              color: Colors.red)),
                                      Text(
                                        "Note: ${list[index]['Expense Note'].toString()}",
                                        style:
                                            const TextStyle(color: Colors.red),
                                      ),
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
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Card(
                                child: ListTile(
                                  leading: Icon(
                                    Icons.monetization_on,
                                    size: 70,
                                    color: Colors.purple.shade800,
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(list[index]['Expense name']
                                          .toString()),
                                      Text(
                                        "Amount: \$${list[index]['Expense amount'].toString()}",
                                        style:
                                            const TextStyle(color: Colors.red),
                                      ),
                                      Text(
                                          "Date: ${list[index]['Date'].toString()}",
                                          style: const TextStyle(
                                              color: Colors.red)),
                                      Text(
                                          "Time: ${list[index]['time'].toString()}",
                                          style: const TextStyle(
                                              color: Colors.red)),
                                      Text(
                                        "Note: ${list[index]['Expense Note'].toString()}",
                                        style:
                                            const TextStyle(color: Colors.red),
                                      ),
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
