import 'package:buyit_ecommerce_app/widget/custom_textfeild.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProduct extends StatelessWidget {
  static String id = 'AddProduct';
  String _name, _price, _description, _category, _location;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeData.dark().scaffoldBackgroundColor, //(0xff2B2B2B)
      appBar: AppBar(
        title: Text('AddProduct'),
        backgroundColor: ThemeData.dark().secondaryHeaderColor,
      ),
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTextField(
              icon: Icons.add,
              hint: 'Product Name',
              hide: false,
              onClick: (value) {
                _name = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              icon: Icons.payment,
              hint: 'Product Price',
              hide: false,
              onClick: (value) {
                _price = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              icon: Icons.description,
              hint: 'Product Description',
              hide: false,
              onClick: (value) {
                _description = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              icon: Icons.category,
              hint: 'Product Category',
              hide: false,
              onClick: (value) {
                _category = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              icon: Icons.image,
              hint: 'Product Location',
              hide: false,
              onClick: (value) {
                _location = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 50),
              color: Colors.blue,
              shape: StadiumBorder(),
              child: Text('Add Product'),
              onPressed: () {
                if (_globalKey.currentState.validate()) {
                  _globalKey.currentState.save();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
