import 'package:buyit_ecommerce_app/models/product.dart';
import 'package:buyit_ecommerce_app/services/store.dart';
import 'package:buyit_ecommerce_app/widget/showAlertDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'edit_product.dart';

class MangeProduct extends StatefulWidget {
  static String id = 'MangeProduct';

  @override
  _MangeProductState createState() => _MangeProductState();
}

class _MangeProductState extends State<MangeProduct> {
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Mange Product'),
        backgroundColor: Colors.amber,
      ),
      //to await data to load then show it
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadProduct(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> products = [];
              for (var doc in snapshot.data.documents) {
                var data = doc.data;
                products.add(Product(
                    pId: doc.documentID,
                    pName: data[kProductName],
                    pLocation: data[kProductLocation],
                    pCategory: data[kProductCategory],
                    pDescription: data[kProductDescription],
                    pPrice: data[kProductPrice]));
              }

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: .8),
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: GestureDetector(
                    //to detect th position of click in screen
                    onTapUp: (details) {
                      //dx is position from  left || dy is position from Top
                      double dx = details.globalPosition.dx;
                      double dy = details.globalPosition.dy;
                      //dR is position from Right => (ScreenWidth-dX) || same to db 'Bottom'
                      double dR = (MediaQuery.of(context).size.width) - dx;
                      double dB = (MediaQuery.of(context).size.height) - dy;
                      showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(dx, dy, dR, dB),
                          items: [
                            MyPopMenuItem(
                              onClick: ()  {
                                //arguments to take info of product (we need document id)
                                Navigator.pushNamed(context, EditProduct.id,arguments: products[index]);
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
                              onClick:
                                  (){
                                    showAlertDialog(context: context,
                                    title: 'Delete',
                                      subtitle: "Are you sure Delete this Element?",
                                      LButtonName: 'cancel',
                                      LbuttonOnClock: (){Navigator.pop(context);},
                                      RButtonName: 'Delete',
                                      RbuttonOnClock: (){
                                      _store.deleteProduct(products[index].pId);
                                      Navigator.pop(context);},

                                    );
//                                _store.deleteProduct(products[index].pId);
                                print('delete is clicked');
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
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          border: Border.all(
                            color: Colors.teal,
                            width: 2,
                          )),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Image(
//                        fit: BoxFit.fill,
                              image: AssetImage(products[index].pLocation),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
//                          child: Opacity(
//                            opacity: .5,
                            child: Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              color: ThemeData.dark()
                                  .scaffoldBackgroundColor
                                  .withOpacity(.5),
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
//                          ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                itemCount: products.length,
              );
            } else {
              return Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Loading...',style: TextStyle(color: Colors.white),),
                  SizedBox(
                    height: 5,
                  ),
                  CircularProgressIndicator(),
                ],
              ));
            }
          }),
    );
  }
}




class MyPopMenuItem<T> extends PopupMenuItem<T> {
  final Widget child;
  final Function onClick;
  MyPopMenuItem({@required this.onClick, @required this.child})
      : super(child: child);

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return MyPopMenuItemState();
  }
}

class MyPopMenuItemState<T, PopupMenuItem>
    extends PopupMenuItemState<T, MyPopMenuItem<T>> {
  @override
  void handleTap() {
    widget.onClick();
  }
}
