import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_pos_clone/utils/utils.dart';
import 'package:smart_pos_clone/widgets/button.dart';
import 'package:smart_pos_clone/widgets/textfield.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final namecontroller = TextEditingController();
  final notecontroller = TextEditingController();
  final amountcontroller = TextEditingController();
  final datecontroller = TextEditingController();
  final timecontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final ref = FirebaseDatabase.instance.ref('Expenses');
  final id = DateTime.now().microsecondsSinceEpoch.toString();

  @override
  void initState() {
    super.initState();
    var time = DateFormat().add_jm().format(DateTime.now());
    var date = DateFormat().add_yMd().format(DateTime.now());

    datecontroller.text = date.toString();
    timecontroller.text = time.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.purple.shade800,
          centerTitle: true,
          title: const Text(
            "Add Supplier",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: _buildAddEpenseScreen());
  }

  _buildAddEpenseScreen() {
    return SingleChildScrollView(
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            CustomTextField(
              Fieldcontroller: namecontroller,
              height: 20,
              name: "Expense Name",
              type: TextInputType.name,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Expense Name";
                }
                return null;
              },
            ),
            CustomTextField(
              Fieldcontroller: notecontroller,
              height: 80,
              name: "Expense Note",
              type: TextInputType.name,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Expense note";
                }
                return null;
              },
            ),
            CustomTextField(
              Fieldcontroller: amountcontroller,
              type: TextInputType.number,
              height: 20,
              name: "Expense ammount",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Expense amount";
                }
                return null;
              },
            ),
            CustomTextField(
              Fieldcontroller: datecontroller,
              height: 20,
              type: TextInputType.datetime,
              name: "Expense Date",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Expense Date";
                }
                return null;
              },
            ),
            CustomTextField(
              Fieldcontroller: timecontroller,
              height: 20,
              type: TextInputType.datetime,
              name: "Expense Time ",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Expense Time";
                }
                return null;
              },
            ),
            Button(
                ontap: () {
                  if (_formkey.currentState!.validate()) {}

                  ref.child(id).set({
                    'id': id,
                    "Expense name": namecontroller.text.toString(),
                    "Expense Note": notecontroller.text.toString(),
                    "Expense amount": amountcontroller.text.toString(),
                    "Date": datecontroller.text.toString(),
                    "time": timecontroller.text.toString()
                  }).then((value) {
                    return Utils().toastMessage("Expense Addded");
                  }).onError((error, stackTrace) {
                    return Utils().toastMessage("Expense not Added!!! ERROR");
                  });
                  namecontroller.clear();
                  notecontroller.clear();
                  amountcontroller.clear();
                  Navigator.pop(context);
                },
                name: "Add Expense")
          ],
        ),
      ),
    );
  }
}
