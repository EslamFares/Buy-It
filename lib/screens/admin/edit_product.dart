
import 'package:buyit_ecommerce_app/constants.dart';
import 'package:buyit_ecommerce_app/models/product.dart';
import 'package:buyit_ecommerce_app/services/store.dart';
import 'package:buyit_ecommerce_app/widget/custom_textfeild.dart';
import 'package:flutter/material.dart';

class EditProduct extends StatelessWidget {
  static String id = 'EditProduct';
  @override
  Widget build(BuildContext context) {
    // to receive  documentId but i send all  product document  in 'arguments'
     Product product= ModalRoute.of(context).settings.arguments;
    String _name, _price, _description, _category, _location;
    final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
    final _store = Store();
    return Scaffold(
      backgroundColor: ThemeData.dark().scaffoldBackgroundColor, //(0xff2B2B2B)
      appBar: AppBar(
        title: Text('Edit Product'),
        backgroundColor: Colors.pink,
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
                initialValue: product.pName,
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
                initialValue: product.pPrice,
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
                initialValue: product.pDescription,
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
                initialValue: product.pCategory,
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
                initialValue: product.pLocation,
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
                padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                color: Colors.pink,
                shape: StadiumBorder(),
                child: Text('Edit Product'),
                onPressed: () {
                  if (_globalKey.currentState.validate()) {
                    _globalKey.currentState.save();
                    _store.editProduct((
                        {kProductName:_name,
                        kProductPrice:_price,
                          kProductCategory:_category,
                          kProductDescription:_description,
                          kProductLocation:_location

                        }
                    ), product.pId);
                    Navigator.pop(context);
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
