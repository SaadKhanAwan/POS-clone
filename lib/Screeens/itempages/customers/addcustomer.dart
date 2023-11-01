import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_pos_clone/utils/utils.dart';
import 'package:smart_pos_clone/widgets/button.dart';
import 'package:smart_pos_clone/widgets/textfield.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({super.key});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final namecontroller = TextEditingController();
  final cellcontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final def = FirebaseDatabase.instance.ref('customers');
  final id = DateTime.now().microsecondsSinceEpoch.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.purple.shade800,
        centerTitle: true,
        title: const Text(
          "Add Customer",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _buildAddCustomerScreen(),
    );
  }

  _buildAddCustomerScreen() {
    return SingleChildScrollView(
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            CustomTextField(
              Fieldcontroller: namecontroller,
              height: 20,
              name: "Customer Name",
              type: TextInputType.name,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter customer Name";
                }
                return null;
              },
            ),
            CustomTextField(
              Fieldcontroller: cellcontroller,
              type: TextInputType.number,
              height: 20,
              name: "Customer Cell",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter customer Cell";
                }
                return null;
              },
            ),
            CustomTextField(
              Fieldcontroller: emailcontroller,
              height: 20,
              type: TextInputType.emailAddress,
              name: "Customer Email",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter customer Email";
                }
                return null;
              },
            ),
            CustomTextField(
              Fieldcontroller: addresscontroller,
              height: 80,
              type: TextInputType.streetAddress,
              name: "Customer Address ",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter customer Address";
                }
                return null;
              },
            ),
            Button(
                ontap: () {
                  if (_formkey.currentState!.validate()) {}

                  def.child(id).set({
                    'id': id,
                    'name': namecontroller.text.toString(),
                    'cell': int.parse(cellcontroller.text.toString()),
                    'email': emailcontroller.text.toString(),
                    'address': addresscontroller.text.toString(),
                  }).then((value) {
                    return Utils().toastMessage("Customer Addded");
                  }).onError((error, stackTrace) {
                    return Utils().toastMessage("Customer not added!!! ERROR");
                  });
                  Navigator.pop(context);
                  namecontroller.clear();
                  cellcontroller.clear();
                  emailcontroller.clear();
                  addresscontroller.clear();
                },
                name: "Add Customer")
          ],
        ),
      ),
    );
  }
}
