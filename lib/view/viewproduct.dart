import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplecrudapplication/model/product.dart';
import 'package:simplecrudapplication/urils/mydio.dart';
import 'package:simplecrudapplication/widget/optionmenu.dart';
import 'addproduct.dart';
import 'package:connectivity/connectivity.dart';
import 'details_screen.dart';

bool online = false;

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<ProductModel> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getProducts((response) {
      setState(() {
        _products = response;
        _isLoading = false;
      });
    });
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    online = connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _products.clear();
      checkConnection();
      _isLoading = true;
    });
    getProducts((response) {
      setState(() {
        _products = response;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    checkConnection();
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List (${online == true ? "Online" : "Offline"})'),
        actions: myMenu(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Get.to(CreateProductScreen()),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  return Card(
                    elevation: 4,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: ListTile(
                      leading: SizedBox(
                        width: 60,
                        height: 60,
                        child: product.image != null
                            ? (product.image!.contains("/data/")
                                ? Image.file(File(product.image!))
                                : Image.network(product.image!))
                            : const Icon(Icons.image),
                      ),
                      title: Text(product.name!),
                      subtitle: Text(product.description!),
                      trailing: Text(
                          "${(product?.image ?? "").contains("/data/") ? "Local" : "Cloud"} image"),
                      onTap: () => Get.to(DetailsScreen(), arguments: product),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
