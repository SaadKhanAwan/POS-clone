import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_pos_clone/utils/utils.dart';

import '../../../widgets/button.dart';
import '../../../widgets/textfield.dart';

// ignore: must_be_immutable
class EditCustomer extends StatefulWidget {
  String name;
  String cell;
  String email;
  String address;
  String id;
  EditCustomer(
      {super.key,
      required this.name,
      required this.cell,
      required this.email,
      required this.address,
      required this.id});

  @override
  State<EditCustomer> createState() => _EditCustomerState();
}

class _EditCustomerState extends State<EditCustomer> {
  final enamecontroller = TextEditingController();
  final ecellcontroller = TextEditingController();
  final eemailcontroller = TextEditingController();
  final eaddresscontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final def = FirebaseDatabase.instance.ref('customers');
  @override
  Widget build(BuildContext context) {
    enamecontroller.text = widget.name;
    ecellcontroller.text = widget.cell;
    eemailcontroller.text = widget.email;
    eaddresscontroller.text = widget.address;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.purple.shade800,
        centerTitle: true,
        title: const Text(
          "Update Customer",
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
              Fieldcontroller: enamecontroller,
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
              Fieldcontroller: ecellcontroller,
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
              Fieldcontroller: eemailcontroller,
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
              Fieldcontroller: eaddresscontroller,
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

                  def.child(widget.id).update({
                    'name': enamecontroller.text.toString(),
                    'cell': int.parse(ecellcontroller.text.toString()),
                    'email': eemailcontroller.text.toString(),
                    'address': eaddresscontroller.text.toString(),
                  }).then((value) {
                    return Utils()
                        .toastMessage("Customer Updated Succussfully");
                  }).onError((error, stackTrace) {
                    return Utils()
                        .toastMessage("Customer not Updated!!! ERROR");
                  });
                  Navigator.pop(context);
                  enamecontroller.clear();
                  ecellcontroller.clear();
                  eemailcontroller.clear();
                  eaddresscontroller.clear();
                },
                name: "Update Customer")
          ],
        ),
      ),
    );
  }
}
