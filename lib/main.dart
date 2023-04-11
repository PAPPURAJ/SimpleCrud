import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplecrudapplication/view/login.dart';
import 'package:simplecrudapplication/view/viewproduct.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var directory=await getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);
  await Hive.openBox('Login');
  await Hive.openBox('Product');
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String username=Hive.box("Login").get("username",defaultValue: "NA");
    String password=Hive.box("Login").get("password",defaultValue: "NA");
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple CRUD Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:username=="NA" && password!="NA"?SignIn():ProductListScreen(), //Text(s)//
    );
  }
}
