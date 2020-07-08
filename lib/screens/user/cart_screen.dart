import 'package:buyit_ecommerce_app/models/product.dart';
import 'package:buyit_ecommerce_app/provider/cart_item.dart';
import 'package:buyit_ecommerce_app/screens/user/product_info.dart';
import 'package:buyit_ecommerce_app/services/store.dart';
import 'package:buyit_ecommerce_app/widget/custom_menu.dart';
import 'package:buyit_ecommerce_app/widget/floating_alert.dart';
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
      resizeToAvoidBottomPadding: false,
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
                          showCustomMenu(details, context, products[index]);
                        },
                        child: Container(
                          height: screenHeight * .16,
                          width: screenWidth,
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: kSecColor,
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                products[index].pName,
                                                style: TextStyle(
                                                    letterSpacing: 1.2,
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                '${products[index].pPrice} \$',
                                                style: TextStyle(
                                                    color: Colors.greenAccent,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Container(
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                border: Border.all(
                                                    color: Colors.amber,
                                                    width: 2)),
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
                                    Container(
                                      width: 150,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                              color: Colors.amber, width: 2)),
                                      child: Center(
                                        child: Text(
                                          'Total : ${int.parse(products[index].pPrice) * products[index].pQuantity.toInt()} \$',
                                          style: TextStyle(
                                              color: Colors.greenAccent,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
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
            child: Builder(
              builder: (context) => ButtonTheme(
                minWidth: 300,
                height: screenHeight / 16,
                child: RaisedButton(
                  shape: StadiumBorder(),
                  onPressed: () {
                    showCustomDialog(products, context);
                  },
                  child: Text(
                    'Order'.toUpperCase(),
                    style: TextStyle(fontSize: 20, letterSpacing: 1.2),
                  ),
                  color: Colors.amber,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void showCustomMenu(details, context, product) async {
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
              Provider.of<CartItem>(context, listen: false)
                  .deleteProduct(product);
              Navigator.pushNamed(context, ProductInfo.id, arguments: product);
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
                  Provider.of<CartItem>(context, listen: false)
                      .deleteProduct(product);
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

  void showCustomDialog(List<Product> products, context) async {
    var price = getTotallPrice(products);
    var address;
    AlertDialog alertDialog = AlertDialog(
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        MaterialButton(
          onPressed: () {
            try {
              Store _store = Store();
              _store.storeOrders({
                kTotalPrice: price,
                kAddress: address,
              }, products);

              FloatAlert(
                  context: context,
                  content: 'Ordered Successfully',
                  width: 250);
              Navigator.pop(context);
            } catch (ex) {
              print(ex.message);
            }
          },
          child: Text(
            'OK',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          side: BorderSide(color: Colors.redAccent, width: 3)),
      elevation: 10,
      content: TextField(
        onChanged: (value) {
          address = value;
        },
        decoration: InputDecoration(
            hintText: 'Enter your Address',
            prefixIcon: Icon(
              Icons.location_on,
              color: Colors.amber,
              size: 25,
            )),
      ),
      title: Row(
        children: <Widget>[
          Text(
            'Total Price : ',
            style: TextStyle(color: Colors.black),
          ),
          Text(
            '$price\$',
            style: TextStyle(color: Colors.red[600]),
          ),
        ],
      ),
    );
    await showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  getTotallPrice(List<Product> products) {
    var price = 0;
    for (var product in products) {
      price += product.pQuantity * int.parse(product.pPrice);
    }
    return price;
  }
}
