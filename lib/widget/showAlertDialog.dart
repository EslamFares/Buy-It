import 'package:flutter/material.dart';

showAlertDialog(
    {BuildContext context,
    String LButtonName,
    String RButtonName,
    String title,
    String subtitle,
    Function LbuttonOnClock,
    Function RbuttonOnClock}) {
  Widget cancelButton = FlatButton(
    child: Text(LButtonName),
    onPressed: LbuttonOnClock,
  );
  Widget continueButton = FlatButton(
    child: Text(RButtonName),
    onPressed: RbuttonOnClock,
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(subtitle),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
