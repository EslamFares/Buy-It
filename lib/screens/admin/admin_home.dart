import 'package:buyit_ecommerce_app/screens/admin/add_product.dart';
import 'package:buyit_ecommerce_app/screens/admin/order_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:buyit_ecommerce_app/screens/admin/mange_product.dart';
class AdminHome extends StatelessWidget {
  static String id = 'AdminHome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF343442),
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(.8),
        title: Text('Admin Page',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: double.infinity,),
          Container(
            width: 250,
            child: RaisedButton(
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
              color: Colors.blue,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add,color: Colors.black,),
                  SizedBox(width: 25,),
                  Text('Add Product',style: TextStyle(color: Colors.white),),
                ],
              ),
              onPressed: (){
                Navigator.pushNamed(context, AddProduct.id);
              },
            ),
          ),
          SizedBox(height: 30,),
          Container(
            width: 250,
            child: RaisedButton(
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
              color: Colors.teal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.edit,color: Colors.black,),
                  SizedBox(width: 20,),
                  Text('Mange Product',style: TextStyle(color: Colors.white),),
                ],
              ),
              onPressed: (){
                Navigator.pushNamed(context, MangeProduct.id);
              },
            ),
          ),
          SizedBox(height: 30,),
          Container(
            width: 250,
            child: RaisedButton(
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
              color: Colors.grey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.reorder,color: Colors.black,),
                  SizedBox(width: 20,),
                  Text('View orders',style: TextStyle(color: Colors.white),),
                ],
              ),
              onPressed: (){
                Navigator.pushNamed(context, OrderScreen.id);
              },
            ),
          ),
        ],
      ),
    );
  }
}
