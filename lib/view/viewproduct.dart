import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:simplecrudapplication/model/product.dart';
import 'package:simplecrudapplication/widget/optionmenu.dart';
import 'addproduct.dart';

import 'details_screen.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<ProductModel> _products = [];
  bool _isLoading = false;

  Future<void> _fetchProducts() async {
    setState(() {
      _isLoading = true;
    });
    final dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImF1dGgiOiJST0xFX0FETUlOLFJPTEVfVVNFUiIsImV4cCI6MTY4MzcyMDkxOH0.hE0dqdA9viExGxMPRPM8p3V4H7jjlbvNhz5Z1CaZoJ9i0id1JsU4TFLmtrkNE6UHSSd7T3gPkri3z_fDFrZ_xA';
    final response = await dio.get('https://secure-falls-43052.herokuapp.com/api/products?page=0&size=20');
    final data = response.data as List<dynamic>;
    setState(() {

      _products=data.map((e) =>ProductModel.fromJson(e)).toList();
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        actions: myMenu(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>Get.to(CreateProductScreen()),
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return ListTile(
            // leading: Image.file(
            //   ,
            //   width: 80,
            //   height: 80,
            //   fit: BoxFit.cover,
            // ),
            title: Text(product.name!),
             subtitle: Text(product.name!),
           //  trailing: Text(product.description!),
            onTap: ()=>Get.to(DetailsScreen(), arguments: product),
          );
        },
      ),
    );
  }
}
