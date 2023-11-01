import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_pos_clone/utils/utils.dart';
import 'package:smart_pos_clone/widgets/button.dart';
import 'package:smart_pos_clone/widgets/textfield.dart';

class AddSupplier extends StatefulWidget {
  const AddSupplier({super.key});

  @override
  State<AddSupplier> createState() => _AddSupplierState();
}

class _AddSupplierState extends State<AddSupplier> {
  final namecontroller = TextEditingController();
  final contactcontroller = TextEditingController();
  final cellcontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final ref = FirebaseDatabase.instance.ref('Suppliers');
  final id = DateTime.now().microsecondsSinceEpoch.toString();

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
      body: _buildAddSupplierScreen(),
    );
  }

  _buildAddSupplierScreen() {
    return SingleChildScrollView(
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            CustomTextField(
              Fieldcontroller: namecontroller,
              height: 20,
              name: "Supplier Name",
              type: TextInputType.name,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Supplier Name";
                }
                return null;
              },
            ),
            CustomTextField(
              Fieldcontroller: contactcontroller,
              height: 20,
              name: "Supplier Contact person",
              type: TextInputType.name,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Supplier Contact person";
                }
                return null;
              },
            ),
            CustomTextField(
              Fieldcontroller: cellcontroller,
              type: TextInputType.number,
              height: 20,
              name: "Supplier Cell",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Supplier cell";
                }
                return null;
              },
            ),
            CustomTextField(
              Fieldcontroller: emailcontroller,
              height: 20,
              type: TextInputType.emailAddress,
              name: "Supplier Email",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Supplier Email";
                }
                return null;
              },
            ),
            CustomTextField(
              Fieldcontroller: addresscontroller,
              height: 80,
              type: TextInputType.streetAddress,
              name: "Supplier Address ",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Supplier Address";
                }
                return null;
              },
            ),
            Button(
                ontap: () {
                  if (_formkey.currentState!.validate()) {}
                  ref.child(id).set({
                    'id': id,
                    'supplier name': namecontroller.text.toString(),
                    'supplier contact person':
                        contactcontroller.text.toString(),
                    'Supplier cell': int.parse(cellcontroller.text.toString()),
                    'Supplier email': emailcontroller.text.toString(),
                    'Supplier address': addresscontroller.text.toString(),
                  }).then((value) {
                    return Utils().toastMessage("Customer Addded");
                  }).onError((error, stackTrace) {
                    return Utils().toastMessage("Customer not added!!! ERROR");
                  });
                  Navigator.pop(context);
                },
                name: "Add Supplier")
          ],
        ),
      ),
    );
  }
}
