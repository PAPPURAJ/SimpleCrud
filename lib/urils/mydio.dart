import 'package:dio/dio.dart';

Future<bool> deleteProduct(int id, String token) async {
  Dio dio = new Dio();
  dio.options.headers["Authorization"] = "Bearer " + token;

  try {
    Response response = await dio.delete("https://secure-falls-43052.herokuapp.com/api/products/$id");
    print(response.statusCode); // prints the status code of the response
    return true;
  } catch (e) {
    print(e);
  }
  return false;
}
