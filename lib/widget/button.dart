import 'package:flutter/material.dart';

Widget myButton(BuildContext context,String text, Function function,double widthRatio){
  return Container(
    padding: EdgeInsets.symmetric(vertical: 16.0),
    width: MediaQuery.of(context).size.width*widthRatio,
    child: ElevatedButton(
      onPressed: ()=>function(),
      style: ElevatedButton.styleFrom(
        primary: Colors.red, // background color
        onPrimary: Colors.white, // foreground color
        shadowColor: Colors.green, // elevation color
        elevation: 5, // elevation of button
      ),
      child:  Text(text),
    ),
  );


}

Widget myRactanButton(BuildContext context,String text, Function function,double widthRatio,Color colors){
  return Container(
    padding: EdgeInsets.symmetric(vertical: 16.0),
    width: MediaQuery.of(context).size.width*widthRatio,
    child: ElevatedButton(
      onPressed:()=> function(),
      style: ElevatedButton.styleFrom(
        primary: Colors.red, // background color
        onPrimary: Colors.white, // foreground color
        shadowColor: Colors.green, // elevation color
        elevation: 5, // elevation of button
      ),
      child:  Text(text),
    ),
  );


}