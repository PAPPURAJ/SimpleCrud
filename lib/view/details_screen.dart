import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplecrudapplication/model/product.dart';
import 'package:simplecrudapplication/urils/mydio.dart';
import 'package:simplecrudapplication/widget/button.dart';
import 'package:simplecrudapplication/widget/myyesnodialog.dart';
import 'package:simplecrudapplication/widget/optionmenu.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductModel item = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Details Screen'),
        actions: myMenu(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(item.image as String)),
                  )),
            ),
            Center(
              child: SizedBox(
                width: 400,
                height: 400,
                child: item.image != null
                    ? Image.network(item.image!)
                    : Icon(Icons.image),
              ),
            ),
            SizedBox(height: 16.0),
            Text('Name: ${item.name ?? ''}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8.0),
            Text('Barcode: ${item.barcode ?? ''}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8.0),
            Text('Description: ${item.description ?? ''}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8.0),
            Text('Subcategory: ${item.subCategory?.name ?? ''}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8.0),
            Text('Brand: ${item.brand?.name ?? ''}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8.0),
            Text('Quantity: ${item.quantity?.quantity.toString() ?? ''}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 8.0),
            Text('Price: ${item.productPrice?.price.toString() ?? ''}',
                style: TextStyle(fontSize: 16)),

            Center(
              child: myButton(context, "Delete", (){
                myYesNoDialog(context, "Want to delete?", ()async{
                  bool response=await deleteProduct(item.id!,"eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImF1dGgiOiJST0xFX0FETUlOLFJPTEVfVVNFUiIsImV4cCI6MTY4MzcyMDkxOH0.hE0dqdA9viExGxMPRPM8p3V4H7jjlbvNhz5Z1CaZoJ9i0id1JsU4TFLmtrkNE6UHSSd7T3gPkri3z_fDFrZ_xA");
                  print("Response: "+response.toString());
                  Get.back();
                }, (){});
              }, 0.8),
            )
          ],
        ),
      ),
    );
  }
}
