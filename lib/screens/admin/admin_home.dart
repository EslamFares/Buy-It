import 'package:buyit_ecommerce_app/screens/admin/add_product.dart';
import 'package:flutter/material.dart';
import '../../colors.dart';
class AdminHome extends StatelessWidget {
  static String id = 'AdminHome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KMainColor,
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: double.infinity,),
          RaisedButton(
            child: Text('Add Product'),
            onPressed: (){
              Navigator.pushNamed(context, AddProduct.id);
            },
          ),
          RaisedButton(
            child: Text('Edit Product'),
            onPressed: (){},
          ),
          RaisedButton(
            child: Text('View orders'),
            onPressed: (){},
          ),
        ],
      ),
    );
  }
}
