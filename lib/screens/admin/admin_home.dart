import 'package:buyit_ecommerce_app/screens/admin/add_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:buyit_ecommerce_app/screens/admin/edit_product.dart';
class AdminHome extends StatelessWidget {
  static String id = 'AdminHome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: double.infinity,),
          Container(
            width: 200,
            child: RaisedButton(
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.grey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add,color: Colors.white,),
                  SizedBox(width: 15,),
                  Text('Add Product',style: TextStyle(color: Colors.black),),
                ],
              ),
              onPressed: (){
                Navigator.pushNamed(context, AddProduct.id);
              },
            ),
          ),
          SizedBox(height: 20,),
          Container(
            width: 200,
            child: RaisedButton(
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.grey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.edit,color: Colors.white,),
                  SizedBox(width: 15,),
                  Text('Edit Product',style: TextStyle(color: Colors.black),),
                ],
              ),
              onPressed: (){
                Navigator.pushNamed(context, EditProduct.id);
              },
            ),
          ),
          SizedBox(height: 20,),
          Container(
            width: 200,
            child: RaisedButton(
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.grey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.reorder,color: Colors.white,),
                  SizedBox(width: 15,),
                  Text('View orders',style: TextStyle(color: Colors.black),),
                ],
              ),
              onPressed: (){},
            ),
          ),
        ],
      ),
    );
  }
}
