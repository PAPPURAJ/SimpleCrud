import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';


class CreateProductScreen extends StatefulWidget {
  @override
  _CreateProductScreenState createState() => _CreateProductScreenState();
}


class _CreateProductScreenState extends State<CreateProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _barcodeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _subCategoryController = TextEditingController();
  final _brandController = TextEditingController();
  final _quantityController = TextEditingController();
  final _unitController = TextEditingController();
  final _unitValueController = TextEditingController();
  final _pastQuantityController = TextEditingController();
  final _priceController = TextEditingController();
  final _unitPriceController = TextEditingController();
  final _mrpController = TextEditingController();

  File? file;
  String imageURL="";

  final imgPicker = ImagePicker();
  Future<void> showOptionsDialog(BuildContext _context) {
    return showDialog(
        context: _context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Options"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: const Text("Capture Image From Camera"),
                    onTap: () async {
                      var imgCamera = await imgPicker.getImage(source: ImageSource.camera);
                      setState(() {
                        file = File(imgCamera!.path);
                        imageURL=imgCamera.path;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: const Text("Take Image From Gallery"),
                    onTap: () async {
                      var imgGallery =
                      await imgPicker.getImage(source: ImageSource.gallery);
                      setState(() {
                        file = File(imgGallery!.path);
                       imageURL=imgGallery.path;
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }


  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final dio = Dio();
      final data = {
        "name": _nameController.text,
        "barcode": _barcodeController.text,
        "description": _descriptionController.text,
        "image": imageURL,
        "subCategory": {
                  "id": 1851,
                  "name": "Traditional Clothing",
                  "image": "https://static-01.daraz.com.bd/p/9c2c14d484ee2f25d22677e0a0b6bcb2.jpg",
                  "description": "Traditional Clothing",
                  "category": {
                    "id": 1801,
                    "name": null,
                    "image": null,
                    "description": null
                  }
                },
        "brand": {
                "id": 2551,
                "name": "Traditional Clothing",
                "image": "https://static-01.daraz.com.bd/p/9c2c14d484ee2f25d22677e0a0b6bcb2.jpg",
                "description": "Traditional Clothing",
                "image":"string"
              },
        "quantity": {
          "id":2254,
          "quantity": int.parse(_quantityController.text),
          "unit": _unitController.text,
          "unitValue": int.parse(_unitValueController.text),
          "pastQuantity": int.parse(_pastQuantityController.text),
        },
        "productPrice": {
          "id":2308,
          "price": int.parse(_priceController.text),
          "unitPrice": int.parse(_unitPriceController.text),
          "mrp": int.parse(_mrpController.text),
        }
      };

      final response = await dio.post(
        "https://secure-falls-43052.herokuapp.com/api/products",
        data: jsonEncode(data),
        options: Options(
          headers: {'Authorization':'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImF1dGgiOiJST0xFX0FETUlOLFJPTEVfVVNFUiIsImV4cCI6MTY4MzcxOTc5Nn0.pdXbk_rLSJN7465uirmaKFi9cbemyiKOj_fc1mB7JWFLLDHl-Xa-ebeAdw8IJ-xQlRFNKWBF8xYle0tNnWEeSw'}
        )
      );
      if (response.statusCode == 200) {
        // Handle success
        print(response.data);
      } else {
        // Handle error
        print(response.statusMessage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: () => showOptionsDialog(context),
                child: Container(
                  child: file != null
                      ? Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(file!),
                        )),
                  )
                      : Container(
                    height: 200,
                    width: 200,
                    decoration:
                    const BoxDecoration(color: Colors.transparent),
                    child: const Image(
                        image:
                        const AssetImage('assets/images/profile.png')),
                  ),
                ),
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _barcodeController,
                decoration: InputDecoration(labelText: 'Barcode'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a barcode';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _subCategoryController,
                decoration: InputDecoration(labelText: 'Subcategory ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a subcategory ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _brandController,
                decoration: InputDecoration(labelText: 'Brand ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a brand ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a quantity';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _unitController,
                decoration: InputDecoration(labelText: 'Unit'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a unit';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _unitValueController,
                decoration: InputDecoration(labelText: 'Unit Value'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a unit value';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _pastQuantityController,
                decoration: InputDecoration(labelText: 'Past Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a past quantity';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _unitPriceController,
                decoration: InputDecoration(labelText: 'Unit Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a unit price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _mrpController,
                decoration: InputDecoration(labelText: 'MRP'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an MRP';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
