import 'package:flutter/material.dart';

Floatngalert({@required BuildContext context,@required String content}){
  Scaffold.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/4),
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(50)),
              height: 35,
              child: Center(
                  child: Text(content,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ))),
        ],
      )));
}