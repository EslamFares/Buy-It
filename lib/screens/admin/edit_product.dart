import 'package:buyit_ecommerce_app/models/product.dart';
import 'package:buyit_ecommerce_app/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class EditProduct extends StatefulWidget {
  static String id = 'EditProduct';

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        backgroundColor: Colors.teal,
      ),
      //to await data to load then show it
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadProduct(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              List<Product> products=[];
              for (var doc in snapshot.data.documents) {
                var data = doc.data;
                products.add(Product(
                    pName: data[kProductName],
                    pLocation: data[kProductLocation],
                    pCategory: data[kProductCategory],
                    pDescription: data[kProductDescription],
                    pPrice: data[kProductPrice]));
              }

            return ListView.builder(
              itemBuilder: (context, index) => Text(products[index].pName),
              itemCount: products.length,
            );}
            else{
             return Center(child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 Text('Loading...'),
                 SizedBox(height: 5,),
                 CircularProgressIndicator(),
               ],
             ));
            }
          }),
    );
  }
}
