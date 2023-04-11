import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplecrudapplication/model/product.dart';
import 'package:simplecrudapplication/urils/mydio.dart';
import 'package:simplecrudapplication/widget/button.dart';
import 'package:simplecrudapplication/widget/myyesnodialog.dart';
import 'package:simplecrudapplication/widget/optionmenu.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductModel item = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
        actions: myMenu(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                  width: 300,
                  height: 300,
                  child: item.image != null
                      ? (item.image!.contains("/data/")
                          ? Image.file(File(item.image!))
                          : Image.network(item.image!))
                      : const Icon(Icons.image)),
            ),
            const SizedBox(height: 20,),
            Card(
              elevation: 4,
              margin: const EdgeInsets.all(20),
              child: Container(
                width:double.infinity,
                margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 18.0),
                    const SizedBox(height: 16.0),
                    Text('Name: ${item.name ?? ''}',
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 8.0),
                    Text('Barcode: ${item.barcode ?? ''}',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8.0),
                    Text('Description: ${item.description ?? ''}',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8.0),
                    Text('Subcategory: ${item.subCategory?.name ?? ''}',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8.0),
                    Text('Brand: ${item.brand?.name ?? ''}',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8.0),
                    Text('Quantity: ${item.quantity?.quantity.toString() ?? ''}',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8.0),
                    Text('Price: ${item.productPrice?.price.toString() ?? ''}',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 18.0),
                  ],
                ),
              ),
            ),

            Center(
              child: myButton(context, "Delete", () {
                myYesNoDialog(context, "Want to delete?", () async {
                  bool response = await deleteProduct(item.id!,
                      "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImF1dGgiOiJST0xFX0FETUlOLFJPTEVfVVNFUiIsImV4cCI6MTY4MzcyMDkxOH0.hE0dqdA9viExGxMPRPM8p3V4H7jjlbvNhz5Z1CaZoJ9i0id1JsU4TFLmtrkNE6UHSSd7T3gPkri3z_fDFrZ_xA");
                  print("Response: " + response.toString());
                  Fluttertoast.showToast(msg: "Deleted! Scroll down to refresh the list!");
                  Get.back();
                }, () {

                });
              }, 0.8),
            )
          ],
        ),
      ),
    );
  }
}
