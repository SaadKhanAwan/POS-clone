import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_pos_clone/utils/utils.dart';
import 'package:smart_pos_clone/widgets/button.dart';
import 'package:smart_pos_clone/widgets/textfield.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final namecontroller = TextEditingController();
  final codecontroller = TextEditingController();
  final categorycontroller = TextEditingController();
  final describtioncontroller = TextEditingController();
  final buycontroller = TextEditingController();
  final sellcontroller = TextEditingController();
  final stockcontroller = TextEditingController();
  final wightcontroller = TextEditingController();
  final unitcontroller = TextEditingController();
  final suppliercontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final ref = FirebaseDatabase.instance.ref('Products');
  final id = DateTime.now().microsecondsSinceEpoch.toString();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  String SelectedTextUnit = "";

  List weightUnit = [
    'KG',
    'G',
    'L',
    'Pics',
    'Dags',
    'mm',
    'Cm',
    'm',
    'dm',
    'Ft',
    'in',
    'm2'
  ];

  String selectedProduct = '';
  List productCategory = [
    'Glasses',
    'Toys',
    'Watch',
    'Book',
    'Bags',
    'Sports',
    'Dress',
    'Mobile',
    'Electronics',
    'Foods',
    'Drinks',
    'Vegetables'
  ];

  final picker = ImagePicker();
  File? _image;
  Future getImagePicker() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        debugPrint("no image picked");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.purple.shade800,
          centerTitle: true,
          title: const Text(
            "Add Products",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: _buildAddProduct(context));
  }

  _buildAddProduct(BuildContext context) {
    // final def = storage.ref("/foldername $id");
    // final uploadtask = def.putFile(_image!.absolute);

    return SingleChildScrollView(
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            CustomTextField(
              Fieldcontroller: namecontroller,
              height: 20,
              name: "Product Name",
              type: TextInputType.name,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Product Name";
                }
                return null;
              },
            ),
            CustomTextField(
              Fieldcontroller: codecontroller,
              height: 20,
              name: "Product Code",
              type: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Product Code";
                }
                return null;
              },
            ),
            CustomTextField(
              Fieldcontroller: categorycontroller,
              height: 20,
              name: "Product Category",
              type: TextInputType.name,
              ontab: () {
                _showSelectionCategory(context);
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Product Catrgory";
                }
                return null;
              },
            ),
            CustomTextField(
              Fieldcontroller: describtioncontroller,
              type: TextInputType.name,
              height: 80,
              name: "Product Describtion",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Product Describtion";
                }
                return null;
              },
            ),
            CustomTextField(
              Fieldcontroller: buycontroller,
              height: 20,
              type: TextInputType.number,
              name: "Unit Product Buy Price",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Product Buy Price";
                }
                return null;
              },
            ),
            CustomTextField(
              Fieldcontroller: sellcontroller,
              height: 20,
              type: TextInputType.number,
              name: "Product Sell Price ",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Product Sell Price";
                }
                return null;
              },
            ),
            CustomTextField(
              Fieldcontroller: stockcontroller,
              height: 20,
              type: TextInputType.number,
              name: "Product Stock",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Product Stock";
                }
                return null;
              },
            ),
            CustomTextField(
              Fieldcontroller: wightcontroller,
              height: 20,
              type: TextInputType.number,
              name: "Product Weight",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Product Weight";
                }
                return null;
              },
            ),
            CustomTextField(
              Fieldcontroller: unitcontroller,
              height: 20,
              // type: TextInputType.datetime,
              name: "Product Weight Unit",
              ontab: () {
                _showSelectionUnit(context);
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Product Unit";
                }
                return null;
              },
            ),
            CustomTextField(
              Fieldcontroller: suppliercontroller,
              height: 20,
              type: TextInputType.name,
              name: "Product Supplier",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Supplier ";
                }
                return null;
              },
            ),
            _image != null
                ? Image.file(_image!.absolute)
                : GestureDetector(
                    onTap: () {
                      getImagePicker();
                    },
                    child: const Icon(
                      Icons.photo,
                      size: 70,
                    ),
                  ),
            const SizedBox(
              height: 20,
            ),
            Button(
                ontap: () async {
                  if (_formkey.currentState!.validate()) {}
                  // ref.child(id).set({
                  //   'id': id,
                  //   'name': namecontroller.text.toString(),
                  //   'code': codecontroller.text.toString(),
                  //   'Category': categorycontroller.text.toString(),
                  //   'Describbtion': describtioncontroller.text.toString(),
                  //   "Product Buy price":
                  //       int.parse(buycontroller.text.toString()),
                  //   "Product Sell price":
                  //       int.parse(sellcontroller.text.toString()),
                  //   "Product Stock": int.parse(stockcontroller.text.toString()),
                  //   "Product weigth":
                  //       double.parse(wightcontroller.text.toString()),
                  //   "Product weigth unit": unitcontroller.text.toString(),
                  //   "Product Supplier": suppliercontroller.text.toString()

                  // }).then((value) {
                  //   return Utils().toastMessage("Product Addded");
                  // }).onError((error, stackTrace) {
                  //   return Utils().toastMessage("PRoduct not Addded!!! ERROR");
                  // });
                  await uplodit();
                  namecontroller.clear();
                  codecontroller.clear();
                  categorycontroller.clear();
                  describtioncontroller.clear();
                  buycontroller.clear();
                  sellcontroller.clear();
                  stockcontroller.clear();
                  wightcontroller.clear();
                  unitcontroller.clear();
                  suppliercontroller.clear();
                  Navigator.pop(context);
                },
                name: "Add Product"),
          ],
        ),
      ),
    );
  }

  _showSelectionUnit(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("Select Unit"),
              content: SingleChildScrollView(
                child: Column(
                    children: weightUnit.map((option) {
                  return ListTile(
                    title: Text(option),
                    onTap: () {
                      setState(() {
                        SelectedTextUnit = option;
                        unitcontroller.text = SelectedTextUnit;
                      });
                      Navigator.pop(context);
                    },
                  );
                }).toList()),
              ));
        });
  }

  _showSelectionCategory(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("Select Product Category"),
              content: SingleChildScrollView(
                child: Column(
                    children: productCategory.map((options) {
                  return ListTile(
                    title: Text(options),
                    onTap: () {
                      setState(() {
                        selectedProduct = options;
                        categorycontroller.text = selectedProduct;
                      });
                      Navigator.pop(context);
                    },
                  );
                }).toList()),
              ));
        });
  }

  uplodit() async {
    final def = storage.ref("/foldername $id");
    final uploadtask = def.putFile(_image!.absolute);
    await Future.value(uploadtask).then((value) async {
      var newurl = await def.getDownloadURL();
      ref.child("$id").set({
        "id": id,
        'name': namecontroller.text.toString(),
        'code': codecontroller.text.toString(),
        'Category': categorycontroller.text.toString(),
        'Describbtion': describtioncontroller.text.toString(),
        "Product Buy price": int.parse(buycontroller.text.toString()),
        "Product Sell price": int.parse(sellcontroller.text.toString()),
        "Product Stock": int.parse(stockcontroller.text.toString()),
        "Product weigth": double.parse(wightcontroller.text.toString()),
        "Product weigth unit": unitcontroller.text.toString(),
        "Product Supplier": suppliercontroller.text.toString(),
        "image_url": newurl.toString()
      });
    }).then((value) {
      return Utils().toastMessage("Addded");
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      debugPrint("......${error.toString()}.....");
    });
  }
}
