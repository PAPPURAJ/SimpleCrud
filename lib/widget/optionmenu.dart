import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplecrudapplication/view/accountview.dart';
import 'package:hive/hive.dart';
import 'package:simplecrudapplication/view/login.dart';

List<Widget> myMenu() {
  return <Widget>[
    PopupMenuButton<String>(
      color: Colors.white,
      onSelected: (String choice) {
        if (choice == 'Profile Info') {
          Get.to(ProfileView());
        } else if (choice == 'Logout') {
          Hive.box("Login").clear();
          Get.offAll(() => SignIn());
        }
      },
      itemBuilder: (BuildContext context) {
        return [
           PopupMenuItem<String>(
            value: 'Profile Info',
            child: Row(
              children: const <Widget>[
                Icon(Icons.info,color: Colors.black,),
                SizedBox(width: 7,),
                Text('Profile Info'),
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: 'Logout',
            child: Row(
              children: const <Widget>[
                Icon(Icons.logout_rounded,color: Colors.black,),
                SizedBox(width: 5,),
                Text('Logout'),
              ],
            ),
          ),
        ];
      },
    ),
  ];
}
