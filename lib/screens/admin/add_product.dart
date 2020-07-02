import 'package:buyit_ecommerce_app/models/product.dart';
import 'package:buyit_ecommerce_app/services/store.dart';
import 'package:buyit_ecommerce_app/widget/custom_textfeild.dart';
import 'package:flutter/material.dart';
class AddProduct extends StatelessWidget {
  static String id = 'AddProduct';
  String _name, _price, _description, _category, _location;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeData.dark().scaffoldBackgroundColor, //(0xff2B2B2B)
      appBar: AppBar(
        title: Text('AddProduct'),
        backgroundColor: ThemeData.dark().secondaryHeaderColor,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              CustomTextField(
                icon: Icons.add,
                hint: 'Product Name',
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
                    //reset() on click save textfeild will be empty to new data
                    _globalKey.currentState.save();
                    _store.addProduct(Product(
                        pName: _name,
                        pPrice: _price,
                        pDescription: _description,
                        pCategory: _category,
                        pLocation: _location));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
