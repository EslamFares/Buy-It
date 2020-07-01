import 'package:buyit_ecommerce_app/colors.dart';
import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  static String id = 'HomeScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KMainColor,
     appBar: (AppBar(title: Text('Home'),)),
    );
  }
}
