import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplecrudapplication/view/login.dart';
import 'package:simplecrudapplication/view/viewproduct.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

String s="";

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("Login");
  await Hive.openBox("Product");
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String apiToken=Hive.box("Login").get("Token",defaultValue: "NA");
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Get Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:apiToken=="NA"?SignIn():ProductListScreen(), //Text(s)//
    );
  }
}
