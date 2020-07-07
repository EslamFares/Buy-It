import 'package:buyit_ecommerce_app/models/product.dart';
import 'package:buyit_ecommerce_app/provider/cart_item.dart';
import 'package:buyit_ecommerce_app/screens/user/product_info.dart';
import 'package:buyit_ecommerce_app/widget/custom_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:buyit_ecommerce_app/widget/showAlertDialog.dart';
import '../../constants.dart';

class CartScreen extends StatelessWidget {
  static String id = 'CartScreen';
  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CartItem>(context).products;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double statusBArHeight = MediaQuery.of(context).padding.top;
    final double appBarHeight = AppBar().preferredSize.height;
    return Scaffold(
      backgroundColor: kBackgroundUserColor,
      appBar: AppBar(
        backgroundColor: kBackgroundUserColor,
        title: Text(
          'The Cart',
          style: TextStyle(color: Colors.amber),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          LayoutBuilder(builder: (context, constrains) {
            if (products.isNotEmpty) {
              return Container(
                height: screenHeight -
                    screenHeight / 16 -
                    appBarHeight -
                    statusBArHeight -
                    15,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 5, right: 5),
                      child: GestureDetector(
                        onTapUp: (details) {
                          showCustomMenu(details, context,products[index]);
                        },
                        child: Container(
                          height: screenHeight * .15,
                          width: screenWidth,
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: kUnActiveColor,
                          ),
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage(products[index].pLocation),
                                radius: screenHeight * .15 / 2.3,
                                backgroundColor: Colors.amber,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            products[index].pName,
                                            style: TextStyle(
                                                letterSpacing: 1.2,
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '${products[index].pPrice} \$',
                                            style: TextStyle(
                                                color: Colors.greenAccent,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            border: Border.all(
                                                color: Colors.amber, width: 2)),
                                        child: Center(
                                          child: Text(
                                            products[index]
                                                .pQuantity
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: products.length,
                ),
              );
            } else {
              return Container(
                height: screenHeight -
                    screenHeight / 16 -
                    appBarHeight -
                    statusBArHeight -
                    15,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.remove_shopping_cart,
                        size: 80,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Cart is Empty',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 5),
            child: ButtonTheme(
              minWidth: 300,
              height: screenHeight / 16,
              child: RaisedButton(
                shape: StadiumBorder(),
                onPressed: () {
                  print(screenHeight);
                },
                child: Text(
                  'Order'.toUpperCase(),
                  style: TextStyle(fontSize: 20, letterSpacing: 1.2),
                ),
                color: Colors.amber,
              ),
            ),
          )
        ],
      ),
    );
  }

  void showCustomMenu(details, context,product) async {
    //dx is position from  left || dy is position from Top
    double dx = details.globalPosition.dx;
    double dy = details.globalPosition.dy;
    //dR is position from Right => (ScreenWidth-dX) || same to db 'Bottom'
    double dR = (MediaQuery.of(context).size.width) - dx;
    double dB = (MediaQuery.of(context).size.height) - dy;
    await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(dx, dy, dR, dB),
        items: [
          MyPopMenuItem(
            onClick: () {
              Navigator.pop(context);
              Provider.of<CartItem>(context,listen: false).deleteProduct(product);
              Navigator.pushNamed(context, ProductInfo.id,arguments: product);
            },
            child: Row(
              children: <Widget>[
                Icon(Icons.edit),
                SizedBox(
                  width: 3,
                ),
                Text('Edit'),
              ],
            ),
          ),
          MyPopMenuItem(
            onClick: () {
              Navigator.pop(context);
              showAlertDialog(
                context: context,
                title: 'Delete',
                subtitle: "Are you sure Delete this Element?",
                LButtonName: 'cancel',
                LbuttonOnClock: () {
                  Navigator.pop(context);
                },
                RButtonName: 'Delete',
                RbuttonOnClock: () {
                  Navigator.pop(context);
                  Provider.of<CartItem>(context,listen: false).deleteProduct(product);
                },
              );
            },
            child: Row(
              children: <Widget>[
                Icon(Icons.delete),
                SizedBox(
                  width: 3,
                ),
                Text('Delete'),
              ],
            ),
          ),
        ]);
  }
}
