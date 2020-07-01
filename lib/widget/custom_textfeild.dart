import 'package:flutter/material.dart';
import '../colors.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool hide;
  final Function onClick;
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
      {@required this.hint, this.icon, this.hide, @required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: TextFormField(minLines: 1,
        maxLines: 2,
        // ignore: missing_return
        validator: (value) {
          if (value.isEmpty) {
            return _errorMessage(hint);
          }
        },
        obscureText: hide,
        onSaved: onClick,
        cursorColor: KMainColor,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 18),
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: KMainColor,
          ),
          fillColor: KSecColor,
          filled: true,
          focusColor: KMainColor,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white, width: 2)),
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
