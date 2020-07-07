import 'package:buyit_ecommerce_app/models/product.dart';
import 'package:buyit_ecommerce_app/screens/user/cart_screen.dart';
import 'package:flutter/cupertino.dart';

class CartItem extends ChangeNotifier{
  List<Product> products=[];
addProduct(Product product){
  products.add(product);
  notifyListeners();
}
deleteProduct(Product product){
  products.remove(product);
  notifyListeners();
}

}