import 'package:flutter/material.dart';

void myYesNoDialog(BuildContext context, String title, Function yesFunction,
    Function noFunction) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text('No'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text('Yes'),
        ),
      ],
    ),
  ).then((confirmed) {
    if (confirmed == true) {
      yesFunction();
    } else {
      noFunction();
    }
  });
}
