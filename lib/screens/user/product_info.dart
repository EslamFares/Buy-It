import 'package:buyit_ecommerce_app/models/product.dart';
import 'package:buyit_ecommerce_app/provider/cart_item.dart';
import 'package:buyit_ecommerce_app/widget/floating_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'cart_screen.dart';

class ProductInfo extends StatefulWidget {
  static String id = 'ProductInfo';
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity = 1;
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: kBackgroundUserColor,
      body: Stack(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image(
                image: AssetImage(product.pLocation),
              )),
          Container(
            color: Colors.transparent,
            padding:
                const EdgeInsets.only(top: 40, left: 10, right: 25, bottom: 5),
            height: MediaQuery.of(context).size.height * .1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.amber,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      'Product Info ',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.info,
                      color: Colors.white,
                      size: 20,
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, CartScreen.id);
                  },
                  child: Icon(
                    Icons.shopping_cart,
                    size: 30,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 7,
                  color: kBackgroundUserColor.withOpacity(.5),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              product.pName,
                              style: TextStyle(
                                  letterSpacing: 1.2,
                                  color: Colors.pink,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${product.pPrice}\$',
                              style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Description: ${product.pDescription}',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: subtract,
                      child: ClipOval(
                        child: Material(
                          color: kUnActiveColor,
                          elevation: 10,
                          child: SizedBox(
                              width: 50,
                              height: 50,
                              child: Icon(
                                Icons.remove_circle_outline,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    ButtonTheme(
                      minWidth: 270,
                      height: 55,
                      shape: StadiumBorder(),
                      //Builder to use SnackBar without ERROR
                      child: Builder(
                        builder: (context) => RaisedButton(
                          color: Colors.amber,
                          onPressed: () {
                            addToCart(context, product);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '( ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                _quantity.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                              Text(
                                ' )',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Add to Cart',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      onTap: add,
                      child: ClipOval(
                        child: Material(
                          color: kUnActiveColor,
                          elevation: 15,
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(
                              Icons.add_circle_outline,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  subtract() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  add() {
    if (_quantity < 20) {
      setState(() {
        _quantity++;
      });
    }
  }

  void addToCart(context, product) {
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    product.pQuantity = _quantity;
    cartItem.addProduct(product);
    Floatngalert(context: context, content: "Added to Cart ✔");
    //OR
    // .showSnackBar(SnackBar(content: Text('Added to Cart successfully'),));
  }
}
