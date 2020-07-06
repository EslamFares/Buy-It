import 'package:buyit_ecommerce_app/constants.dart';
import 'package:buyit_ecommerce_app/models/product.dart';
import 'package:buyit_ecommerce_app/services/auth.dart';
import 'package:buyit_ecommerce_app/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../functions.dart';
Widget ProductVeiw_User(String pCategory,List<Product> allProducts) {
  List<Product> products;
  products = getProductByCategory(pCategory,allProducts);
  return  GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: .8),
    itemBuilder: (context, index) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: GestureDetector(
        onTap: () {},
        child: Material(
          color: kBackgroundUserColor,
          elevation: 20,
          borderRadius: BorderRadius.circular(15.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                border: Border.all(
                  color: kBackgroundUserColor,
                  width: 1,
                )),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image(
                    image: AssetImage(products[index].pLocation),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    color: kBackgroundUserColor.withOpacity(.5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Name: ${products[index].pName}",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Price: ${products[index].pPrice}\$',
                            style:
                            TextStyle(color: Colors.amberAccent),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
    itemCount: products.length,
  );
}