import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:simplecrudapplication/constants/api.dart';
import 'package:simplecrudapplication/model/product.dart';
import 'package:connectivity/connectivity.dart';

final dio = Dio();

String getUsername() => Hive.box("Login").get("username", defaultValue: "NA");

String getPassword() => Hive.box("Login").get("password", defaultValue: "NA");

Future<bool> addProduct(var data) async {
  final response = await dio.post(productAddAPIURL,
      data: jsonEncode(data),
      options: Options(headers: {
        'Authorization':
            "Basic ${base64Encode(utf8.encode('${getUsername()}:${getPassword()}'))}"
      }));
  if (response.statusCode == 200) {
    print(response.data);
  } else {
    print(response.statusMessage);
  }
  return false;
}

Future<bool> getProducts(Function res) async {
  List<ProductModel> productList = [];
  var hive = Hive.box("Product");
  final dio = Dio();

  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    dio.options.headers['Authorization'] =
        "Basic ${base64Encode(utf8.encode('${getUsername()}:${getPassword()}'))}";
    final response = await dio.get(productGetAPIURL);

    final data = response.data as List<dynamic>;
    hive.put("key", data);
    productList = data.map((e) => ProductModel.fromJson(e)).toList();
  } else {
    final response = hive.get("key") as List<dynamic>;
    productList = response.map((e) => ProductModel.fromJson(e)).toList();
  }
  print("==================${productList.length}=======================");

  res(productList);
  return false;
}

Future<bool> deleteProduct(int id, String token) async {
  dio.options.headers["Authorization"] =
      "Basic ${base64Encode(utf8.encode('${getUsername()}:${getPassword()}'))}";
  try {
    Response response = await dio.delete("$productDetAPIURL$id");
    print(response.statusCode);
    return true;
  } catch (e) {
    print(e);
  }
  return false;
}

void viewAccount(Function f) async {
  dio.options.headers['Authorization'] =
      "Basic ${base64Encode(utf8.encode('${getUsername()}:${getPassword()}'))}";
  try {
    final response = await dio.get(accountAPIURL);
    f(response);
  } catch (e) {
    print(e.toString());
  }
}
