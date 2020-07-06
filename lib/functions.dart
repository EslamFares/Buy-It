import 'package:buyit_ecommerce_app/constants.dart';
import 'package:buyit_ecommerce_app/models/product.dart';
import 'package:buyit_ecommerce_app/services/auth.dart';
import 'package:buyit_ecommerce_app/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<Product> getProductByCategory(String kJackets,List<Product> allProducts) {
  List<Product> products=[];
  try{
  for(var product in allProducts){
    if(product.pCategory==kJackets){
      products.add(product);
    }
  }}on Error catch(ex){
    print(ex);
  }
  return products;
}