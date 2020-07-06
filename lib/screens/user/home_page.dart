import 'package:buyit_ecommerce_app/constants.dart';
import 'package:buyit_ecommerce_app/models/product.dart';
import 'package:buyit_ecommerce_app/services/auth.dart';
import 'package:buyit_ecommerce_app/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomeScreen';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = Auth();
  FirebaseUser _loggedUser;
  int _tabBarIndex = 0;
  final _store = Store();
  int _bottomNavigationBar=0;
  @override
  void initState() {
    getCurrentUser();
  }

  getCurrentUser() async {
    _loggedUser = await _auth.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              onTap: (value){setState(() {
                _bottomNavigationBar=value;
              });},
              currentIndex: _bottomNavigationBar,
              backgroundColor: kBackgroundUserColor,
              elevation: 10,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home),title: Text('Home')),
                BottomNavigationBarItem(icon: Icon(Icons.search),title: Text('Search')),
                BottomNavigationBarItem(icon: Icon(Icons.person),title: Text('Profile')),
              ],
            ),
            backgroundColor: kBackgroundUserColor,
            appBar: AppBar(
              backgroundColor: kBackgroundUserColor,
              elevation: 0,
              bottom: TabBar(
                indicatorColor: Colors.amber,
                onTap: (value) {
                  setState(() {
                    _tabBarIndex = value;
                  });
                },
                tabs: <Widget>[
                  Text(
                    'Jackets',
                    style: TextStyle(
                        color: _tabBarIndex == 0
                            ? Colors.white
                            : kUnActiveColor.withOpacity(.4),
                        fontSize: _tabBarIndex == 0 ? 16 : null),
                  ),
                  Text(
                    'Trousers',
                    style: TextStyle(
                        color: _tabBarIndex == 1
                            ? Colors.white
                            : kUnActiveColor.withOpacity(.4),
                        fontSize: _tabBarIndex == 1 ? 16 : null),
                  ),
                  Text(
                    'T-shirts',
                    style: TextStyle(
                        color: _tabBarIndex == 2
                            ? Colors.white
                            : kUnActiveColor.withOpacity(.4),
                        fontSize: _tabBarIndex == 2 ? 16 : null),
                  ),
                  Text(
                    'Shoes',
                    style: TextStyle(
                        color: _tabBarIndex == 3
                            ? Colors.white
                            : kUnActiveColor.withOpacity(.4),
                        fontSize: _tabBarIndex == 3 ? 16 : null),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: jacketView(),
                ),
                Text('test2'),
                Text('test3'),
                Text('test4'),
              ],
            ),
          ),
        ),
        //Buyit and cart
        Material(
          color: kBackgroundUserColor,
          child: Container(
            padding:
                const EdgeInsets.only(top: 50, left: 25, right: 25, bottom: 5),
            height: MediaQuery.of(context).size.height * .12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Buy it',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.shopping_cart,
                  color: Colors.amber,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget jacketView() {
    return StreamBuilder<QuerySnapshot>(
        stream: _store.loadProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;
              if(doc[kProductCategory]=='jackets')
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
//                          ),
                          )
                        ],
                      ),
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
                Text(
                  'Loading...',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 5,
                ),
                CircularProgressIndicator(),
              ],
            ));
          }
        });
  }
}
