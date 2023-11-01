import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_pos_clone/widgets/textfield.dart';

import '../../../utils/utils.dart';
import '../../../widgets/button.dart';

// ignore: must_be_immutable
class EditSupplier extends StatefulWidget {
  var name;
  var cell;
  var email;
  var adress;
  var contact;
  var id;
  EditSupplier(
      {super.key,
      required this.name,
      this.id,
      required this.cell,
      required this.email,
      required this.contact,
      required this.adress});

  @override
  State<EditSupplier> createState() => _EditSupplierState();
}

class _EditSupplierState extends State<EditSupplier> {
  var enamecontroller = TextEditingController();
  var econtactcontroller = TextEditingController();
  var ecellcontroller = TextEditingController();
  var eemailcontroller = TextEditingController();
  var eaddresscontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final ref = FirebaseDatabase.instance.ref('Suppliers');
  @override
  Widget build(BuildContext context) {
    enamecontroller.text = widget.name;
    econtactcontroller.text = widget.contact;
    ecellcontroller.text = widget.cell;
    eemailcontroller.text = widget.email;
    eaddresscontroller.text = widget.adress;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.purple.shade800,
        centerTitle: true,
        title: const Text(
          "Update Supplier",
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
              Fieldcontroller: enamecontroller,
              height: 20,
              name: "Edit Supplier Name",
              type: TextInputType.name,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Supplier Name";
                }
                return null;
              },
            ),
            CustomTextField(
              Fieldcontroller: econtactcontroller,
              height: 20,
              name: "Edit Supplier Contact person",
              type: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Supplier Contact person";
                }
                return null;
              },
            ),
            CustomTextField(
              Fieldcontroller: ecellcontroller,
              type: TextInputType.number,
              height: 20,
              name: "Edit Supplier Cell",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Supplier cell";
                }
                return null;
              },
            ),
            CustomTextField(
              Fieldcontroller: eemailcontroller,
              height: 20,
              type: TextInputType.emailAddress,
              name: "Edit Supplier Email",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Supplier Email";
                }
                return null;
              },
            ),
            CustomTextField(
              Fieldcontroller: eaddresscontroller,
              height: 80,
              type: TextInputType.streetAddress,
              name: "Edit Supplier Address ",
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
                  ref.child(widget.id).update({
                    'supplier name': enamecontroller.text.toString(),
                    'supplier contact person':
                        econtactcontroller.text.toString(),
                    'Supplier cell': ecellcontroller.text.toString(),
                    'Supplier email': eemailcontroller.text.toString(),
                    'Supplier address': eaddresscontroller.text.toString(),
                  }).then((value) {
                    return Utils()
                        .toastMessage("Supplier Updated Succussfully");
                  }).onError((error, stackTrace) {
                    return Utils().toastMessage("Customer not added!!! ERROR");
                  });
                  enamecontroller.clear();
                  econtactcontroller.clear();
                  eemailcontroller.clear();
                  eaddresscontroller.clear();
                  Navigator.pop(context);
                },
                name: "Update Supplier")
          ],
        ),
      ),
    );
  }
}
