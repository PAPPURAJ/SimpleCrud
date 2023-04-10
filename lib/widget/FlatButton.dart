import 'package:flutter/material.dart';

Widget flatButton(BuildContext context, String text, Widget widget) {
  return TextButton(
    style:  ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.red)
            )
        )
    ),
    onPressed: () async {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => widget));
    },
    child: Text(
      text,
      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
    ),

  );
}
