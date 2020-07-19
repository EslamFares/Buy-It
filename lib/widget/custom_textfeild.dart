import 'package:flutter/material.dart';
import '../constants.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;
  final String initialValue;
  String _errorMessage(String str) {
    switch (hint) {
      case 'Enter Your Name':
        return 'Name is empty !';
      case 'Enter Your Email':
        return 'Email is empty !';
      case 'Enter Your Password':
        return 'Password is empty !';
    }
  }

  const CustomTextField(
      {@required this.hint, this.icon, @required this.onClick, this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        initialValue: initialValue,
        minLines: 1,
        maxLines:hint=='Product Description'?3:1,
        // ignore: missing_return
        validator: (value) {
          if (value.isEmpty) {
            return _errorMessage(hint);
          }
        },
        obscureText: hint=='Enter Your Password'?true:false,
        onSaved: onClick,
        cursorColor: Colors.amber,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 18),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white),
          prefixIcon: Icon(
            icon,
            color: Colors.amber,
          ),
          fillColor: kSecColor,
          filled: true,
          focusColor: kBackgroundUserColor,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.amber, width: 3)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.amber, width: 3)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.red, width: 2)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.red, width: 2)),
        ),
      ),
    );
  }
}
