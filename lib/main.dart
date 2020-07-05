import 'package:buyit_ecommerce_app/provider/Admin_mode.dart';
import 'package:buyit_ecommerce_app/provider/modelHud.dart';
import 'package:buyit_ecommerce_app/screens/admin/add_product.dart';
import 'package:buyit_ecommerce_app/screens/admin/edit_product.dart';
import 'file:///C:/Users/Eng%20Eslam/AndroidStudioProjects/buyit_ecommerce_app/lib/screens/admin/admin_home.dart';
import 'file:///C:/Users/Eng%20Eslam/AndroidStudioProjects/buyit_ecommerce_app/lib/screens/user/home_page.dart';
import 'package:buyit_ecommerce_app/screens/login_screen.dart';
import 'package:buyit_ecommerce_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/admin/mange_product.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //to use provider above all screen
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelHud>(
          create: (context) => ModelHud(),
        ),
        ChangeNotifierProvider<AdminMode>(
          create: (context) => AdminMode(),
        )
      ],
      child: MaterialApp(
        title: 'Buy it',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignUPScreen.id: (context) => SignUPScreen(),
          HomePage.id: (context) => HomePage(),
          AdminHome.id: (context) => AdminHome(),
          AddProduct.id: (context) => AddProduct(),
          MangeProduct.id: (context) => MangeProduct(),
          EditProduct.id: (context) => EditProduct(),
        },
      ),
    );
  }
}
