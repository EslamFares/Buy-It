import 'package:buyit_ecommerce_app/constants.dart';
import 'package:buyit_ecommerce_app/models/product.dart';
import 'package:buyit_ecommerce_app/screens/login_screen.dart';
import 'package:buyit_ecommerce_app/screens/user/cart_screen.dart';
import 'package:buyit_ecommerce_app/screens/user/product_info.dart';
import 'package:buyit_ecommerce_app/services/auth.dart';
import 'package:buyit_ecommerce_app/services/store.dart';
import 'package:buyit_ecommerce_app/widget/buyit_logo.dart';
import 'package:buyit_ecommerce_app/widget/productveiw_user.dart';
import 'package:buyit_ecommerce_app/widget/showAlertDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../functions.dart';

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
  int _bottomNavigationBar = 0;
  List<Product> _products;
  @override
  void initState() {
    getCurrentUser();
  }

  getCurrentUser() async {
    _loggedUser = await _auth.getUser();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      HomeBottom(),
      SearchBottom(),
      ProfileBottom(),
    ];
    return
//      Stack(
//      children: <Widget>[
        DefaultTabController(
      length: 4,
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              setState(() {
                _bottomNavigationBar = value;
              });
            },
            currentIndex: _bottomNavigationBar,
            backgroundColor: kBackgroundUserColor,
            elevation: 10,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text('Home')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), title: Text('Search')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), title: Text('Profile')),
            ],
          ),
          backgroundColor: kBackgroundUserColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kBackgroundUserColor,
              title: Text(
                'Buy it',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, CartScreen.id);
                    },
                    child: Icon(
                      Icons.shopping_cart,
                      size: 30,
                      color: Colors.amber,
                    ),
                  ),
                ),
              ],
              elevation: 0,
              bottom: _bottomNavigationBar == 0
                  ? TabBar(
                      unselectedLabelColor: kSecColor.withOpacity(.4),
                      unselectedLabelStyle: TextStyle(fontSize: 14),
                      labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                      labelColor: Colors.white,
                      indicatorColor: Colors.amber,
                      onTap: (value) {
                        setState(() {
                          _tabBarIndex = value;
                        });
                      },
                      tabs: <Widget>[
                        Text(
                          'Jackets',
                        ),
                        Text(
                          'Trousers',
                        ),
                        Text(
                          'T-shirts',
                        ),
                        Text(
                          'Shoes',
                        ),
                      ],
                    )
                  : null,
            ),
          ),
          body: _children[_bottomNavigationBar]
//            HomeButtom(),
          ),
    );
  }

  Widget ProfileBottom() {
    return Center(
      child: ListView(
        children: <Widget>[
          BuyitLogo(
            heightScreen: MediaQuery.of(context).size.height.toInt(),
          ),
          SizedBox(
            height: 150,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 100),
            height: 50,
            width: 200,
            child: OutlineButton(

              padding: EdgeInsets.symmetric(vertical: 10.0),
              shape: StadiumBorder(),

            borderSide: BorderSide(color: Colors.blue,width: 5),
              onPressed: () async {
                showAlertDialog(
                    title: 'Login Out',
                    context: context,
                    subtitle: 'Are you sure log out?',
                    LButtonName: 'Log Out',
                    LbuttonOnClock: () async {
                      if (_bottomNavigationBar == 2) {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.clear();
                        await _auth.SignOut();
                        Navigator.popAndPushNamed(context, LoginScreen.id);
                      }
                    },
                RButtonName: 'Cancel',
                  RbuttonOnClock: (){
                      Navigator.pop(context);
                  }
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.power_settings_new,
                    color: Colors.redAccent,
                    size: 30,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Log Out',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget SearchBottom() => Center(child: Text('Search'));

  Widget HomeBottom() {
    return TabBarView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: jacketView(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: ProductVeiw_User(kTrousers, _products),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: ProductVeiw_User(kTshirts, _products),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: ProductVeiw_User(kShoes, _products),
        ),
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

              products.add(Product(
                  pId: doc.documentID,
                  pName: data[kProductName],
                  pLocation: data[kProductLocation],
                  pCategory: data[kProductCategory],
                  pDescription: data[kProductDescription],
                  pPrice: data[kProductPrice]));
            }
            //'[... ___ ]'to take only the value of products in _products
            // without it they will  be same and when  products.clear() data will delete from 2
            _products = [...products];
            products.clear();
            products = getProductByCategory(kJackets, _products);
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: .8),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProductInfo.id,
                        arguments: products[index]);
                  },
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
                CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.amber),
                ),
              ],
            ));
          }
        });
  }
}
