import 'package:buyit_ecommerce_app/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';

class Store {
  final Firestore _firestore = Firestore.instance;

  addProduct(Product product) {
    _firestore.collection(kProductsCollection).add({
      kProductName: product.pName,
      kProductPrice: product.pPrice,
      kProductDescription: product.pDescription,
      kProductCategory: product.pCategory,
      kProductLocation: product.pLocation
    });
  }

  Stream<QuerySnapshot> loadProduct() {
    return _firestore.collection(kProductsCollection).snapshots();
  }

  Stream<QuerySnapshot> loadOrders() {
    return _firestore.collection(kOrders).snapshots();
  }
  Stream<QuerySnapshot> loadOrderDetails(documentId) {
    return _firestore.collection(kOrders).document(documentId).collection(kOrderDetails).snapshots();
  }

  deleteProduct(documentId){
    _firestore.collection(kProductsCollection).document(documentId).delete();
  }
  editProduct(data,documentId){
    _firestore.collection(kProductsCollection).document(documentId).updateData(data);
  }

  storeOrders(data,List<Product> products) {
    var documentRef = _firestore.collection(kOrders).document();
    documentRef.setData(data);
    for (var product in products) {
      documentRef.collection(kOrderDetails).document().setData({
        kProductName:product.pName,
        kProductPrice:product.pPrice,
        kProductQuantity:product.pQuantity,
        kProductLocation:product.pLocation,
        kProductCategory:product.pCategory
      });
    }
  }


}