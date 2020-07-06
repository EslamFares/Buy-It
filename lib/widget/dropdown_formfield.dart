import 'package:flutter/material.dart';

import '../constants.dart';
String selected;
Widget DropDownButtonFormFieldCategory({@required Function function}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 35),
    child: DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 18),
        hintText: 'Product Category',
        prefixIcon: Icon(
          Icons.category,
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
      value: selected,
      items: ["jackets", "Trousers", "T-shirts",'Shoes']
          .map((label) => DropdownMenuItem(
        child: Text(label),
        value: label,
      ))
          .toList(),
      onChanged: function
    ),
  );
}