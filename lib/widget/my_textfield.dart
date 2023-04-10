

  import 'package:flutter/material.dart';

Widget getTextField(String labeltext, String hint, TextEditingController controller){
  return Container(
      width: 300,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labeltext,
          hintText: hint,
        ),
        autofocus: false,
        controller: controller,
      )
  );
}
Widget getTextFieldDes(String labeltext, String hint, TextEditingController controller){
  return Container(
      width: 300,
      child: TextField(
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        maxLines: null,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labeltext,
          hintText: hint,
        ),
        autofocus: false,
        controller: controller,
      )
  );
}