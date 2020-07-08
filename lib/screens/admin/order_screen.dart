import 'package:buyit_ecommerce_app/constants.dart';
import 'package:buyit_ecommerce_app/models/order.dart';
import 'package:buyit_ecommerce_app/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'order_details.dart';

class OrderScreen extends StatelessWidget {
  static String id = 'OrderScreen';
  final Store _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundUserColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kSecColor,
        title: Text('OrderScreen'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrders(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('There is No Order'),
            );
          } else {
            List<Order> order = [];
            for (var doc in snapshot.data.documents) {
              order.add((Order(
                documentId: doc.documentID,
                  totalPrice: doc.data[kTotalPrice],
                  address: doc.data[kAddress])));
            }
            return ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(top: 10,left: 5,right: 5),
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, OrderDetails.id,arguments: order[index].documentId);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: kSecColor,
                    ),
                    padding: EdgeInsets.all(10.0),
                    height: MediaQuery.of(context).size.height*.15,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.payment,color: Colors.greenAccent,),SizedBox(width: 10,),
                            Row(
                              children: <Widget>[
                                Text('Total Price : ',style: TextStyle(
                                    fontSize: 18,fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),),
                                Text('${order[index].totalPrice } \$',style: TextStyle(
                                    fontSize: 18,fontWeight: FontWeight.bold,
                                    color: Colors.greenAccent
                                ),),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Icon(Icons.location_on,color: Colors.amber,),SizedBox(width: 10,),
                            Row(
                              children: <Widget>[
                                Text('Address     : ',style: TextStyle(
                                  fontSize: 18,fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),),

                                Text('${order[index].address }',style: TextStyle(
                                  fontSize: 18,fontWeight: FontWeight.bold,
                                  color: Colors.amber
                                ),),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              itemCount: order.length,
            );
          }
        },
      ),
    );
  }
}
