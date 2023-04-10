
import 'package:flutter/material.dart';
import 'package:simplecrudapplication/view/viewproduct.dart';
import 'package:simplecrudapplication/widget/button.dart';
import 'package:simplecrudapplication/widget/text_field.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';




class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}


bool rememberLogin=false;

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();




    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: -20,
            right: -70,
            left: -113,
            child: Image.asset('assets/images/ellipse_top.png'),
          ),
          Positioned(
            top: -25,
            right: 0,
            child: Image.asset(
              'assets/images/crop_circle_top.png',
              height: 130,
              width: 130,
              color: const Color(0x330E3305).withOpacity(0.2),
            ),
          ),
          Positioned(
            top: 20,
            left: MediaQuery.of(context).size.width / 6,
            child: Image.asset(
              'assets/images/doel.png',
              height: 170,
              color: const Color(0x330E3305).withOpacity(0.07),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 6,
            left: MediaQuery.of(context).size.width / 3,
            child: const Text(
              "SIGN IN",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 30,
            child: Image.asset(
              'assets/images/doel.png',
              height: 50,
              width: 50,
            ),
          ),
          Positioned(
            bottom: 0,
            right: -13,
            child: Image.asset(
              'assets/images/crop_circle_bottom.png',
              height: 100,
              width: 100,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 5),
                myRecTextField('Username', username!, 0.8),
                const SizedBox(height: 20.0),
                myRecTextField('Password', password!, 0.8),
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: rememberLogin,
                          activeColor: Colors.deepOrange,
                          onChanged: (value) {
                            setState(() {
                              rememberLogin=!rememberLogin;
                            });
                          },
                        ),
                        Text("Remember me")
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                myButton(context, "LOG IN", () {
                  _signInWithNameAndPass(context,username!.text,password!.text);
                }, 0.9),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signInWithNameAndPass(BuildContext context,String usernameSt,String passSt) async {

    final dio = Dio();
    final url = 'https://secure-falls-43052.herokuapp.com/api/authenticate';

    final data = {
      'username': usernameSt,
      'password': passSt,
      'rememberMe': rememberLogin,
    };

    try {
      final response = await dio.post(
        url,
        data: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        print(responseData);
        Get.to(ProductListScreen());
        Hive.box("Login").put("Token",responseData.toString());



      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}