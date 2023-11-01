import 'package:flutter/material.dart';
import 'package:smart_pos_clone/Screeens/itempages/all%20order/Order_Screen.dart';
import 'package:smart_pos_clone/Screeens/itempages/expenses/ExpenseScreen.dart';
import 'package:smart_pos_clone/Screeens/itempages/customers/custompage.dart';
import 'package:smart_pos_clone/Screeens/itempages/pos/pos_Screen.dart';
import 'package:smart_pos_clone/Screeens/itempages/product/productspage.dart';
import 'package:smart_pos_clone/Screeens/itempages/supplier/supplierPage.dart';
import 'package:smart_pos_clone/models/icon_Model/icondata_model.dart';
import 'package:smart_pos_clone/provider/screenprovider.dart';
import 'package:smart_pos_clone/widgets/gridviewCard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.purple.shade800,
          centerTitle: true,
          title: const Text(
            "Smart POS",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        body: _buildAllProducts(context));
  }

  // for  view all items
  _buildAllProducts(BuildContext context) {
    final provider = Screenchangeprovider.of(context);
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (100 / 140),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12),
      itemCount: myproduct.items.length,
      itemBuilder: (context, index) {
        final allproducts = myproduct.items[index];
        return GestureDetector(
          onTap: () {
            _buildScreenShipting(index: 0, name: "CUSTOMERS");
            _buildScreenShipting(index: 1, name: "SUPPLIERS");
            _buildScreenShipting(index: 2, name: "PRODUCTS");
            _buildScreenShipting(index: 3, name: "POS");
            _buildScreenShipting(index: 4, name: "EXPENSE");
            _buildScreenShipting(index: 5, name: "ALL ORDERS");

            // call provider function
            provider.ChangeScreen(index);

            if (provider.counter == 0) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CustomPage()));
            } else if (provider.counter == 1) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SupplierPage()));
            } else if (provider.counter == 2) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProductScreen()));
            } else if (provider.counter == 3) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const POS_Screen()));
            } else if (provider.counter == 4) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ExpenseScreen()));
            } else if (provider.counter == 5) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OrderScreen()));
            }
          },
          child: ViewCard(
            product: allproducts,
          ),
        );
      },
    );
  }

  // for sceen shipting

  _buildScreenShipting({required int index, required String name}) {
    return Text(name);
  }
}
