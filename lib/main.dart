import 'package:buyit_ecommerce_app/provider/modelHud.dart';
import 'package:buyit_ecommerce_app/screens/home_screen.dart';
import 'package:buyit_ecommerce_app/screens/login_screen.dart';
import 'package:buyit_ecommerce_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //to use provider above all screen
    return ChangeNotifierProvider<ModelHud>(
        create: (context) => ModelHud(),
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
            HomeScreen.id: (context) => HomeScreen(),
          },
        ));
  }
}
