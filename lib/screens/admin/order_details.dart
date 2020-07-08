import 'package:buyit_ecommerce_app/constants.dart';
import 'package:buyit_ecommerce_app/models/product.dart';
import 'package:buyit_ecommerce_app/services/store.dart';
import 'package:buyit_ecommerce_app/widget/showAlertDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  static String id = 'OrderDetails';
  Store store = Store();
  @override
  Widget build(BuildContext context) {
    String documentId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('OrderDetails'),
        centerTitle: true,
        backgroundColor: kBackgroundUserColor,

      ),
      backgroundColor: kBackgroundUserColor,
      body: StreamBuilder<QuerySnapshot>(
          stream: store.loadOrderDetails(documentId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> products = [];
              for (var doc in snapshot.data.documents) {
                products.add(Product(
                    pName: doc.data[kProductName],
                    pQuantity: doc.data[kProductQuantity],
                    pCategory: doc.data[kProductCategory],
                    pLocation: doc.data[kProductLocation]));
              }
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            color: kSecColor,
                          ),
                          padding: EdgeInsets.all(10.0),
                          height: MediaQuery.of(context).size.height * .2,
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                maxRadius: 30,
                                minRadius: 20,
                                backgroundColor: Colors.amber,
                                child: Image(image: AssetImage(products[index].pLocation),),
                              ),
                              SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Product Name : ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),Text(
                                        '${products[index].pName}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.amber),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Quantity            : ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ), Container(
                                        width: 50,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                            border: Border.all(
                                                color: Colors.greenAccent, width: 2)),
                                        child: Center(
                                          child: Text(
                                            '${products[index].pQuantity}',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.greenAccent),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Category           : ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        '${products[index].pCategory}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ButtonTheme(
                          shape: StadiumBorder(),
                          minWidth: 120,
                          child: RaisedButton(
                            onPressed: (){},
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.check),
                                SizedBox(width: 10,),
                                Text('Confirm Order'),
                              ],
                            ),
                          ),
                        ),
                        ButtonTheme(
                          shape: StadiumBorder(),
                          minWidth: 120,
                          buttonColor: Colors.red,
                          child: RaisedButton(
                            onPressed: (){

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
                                 //..Do Task
                                },
                              );

                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.delete),
                                SizedBox(width: 10,),
                                Text('Delete Order'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Loading...',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.amber),
                  ),
                ],
              ));
            }
          }),
    );
  }
}
