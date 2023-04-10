import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplecrudapplication/view/accountview.dart';

List<Widget> myMenu(){
  return  <Widget>[
    PopupMenuButton<String>(
      onSelected: (String choice) {
        if (choice == 'Profile Info') {
          Get.to(ProfileView());
        } else if (choice == 'Logout') {

        }
      },
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem<String>(
            value: 'Profile Info',
            child: Text('Profile Info'),
          ),
          const PopupMenuItem<String>(
            value: 'Logout',
            child: Text('Logout'),
          ),
        ];
      },
    ),
  ];
}