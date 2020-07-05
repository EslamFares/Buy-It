import 'package:buyit_ecommerce_app/provider/modelHud.dart';
import 'file:///C:/Users/Eng%20Eslam/AndroidStudioProjects/buyit_ecommerce_app/lib/screens/user/home_page.dart';
import 'package:buyit_ecommerce_app/screens/login_screen.dart';
import 'package:buyit_ecommerce_app/widget/buyit_logo.dart';
import 'package:buyit_ecommerce_app/widget/custom_textfeild.dart';
import 'package:flutter/material.dart';
import 'package:buyit_ecommerce_app/services/auth.dart';
import 'package:flutter/services.dart';
import '../constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SignUPScreen extends StatelessWidget {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  static String id = 'signupscreen';
  String _email, _password;
  final _auth = Auth();
  @override
  Widget build(BuildContext context) {
    int heightScreen = MediaQuery.of(context).size.height.toInt();
    int widthScreen = MediaQuery.of(context).size.width.toInt();
    return Scaffold(
      backgroundColor: KMainColor,
      body: ModalProgressHUD(
        //take it's value(true or false from provider (method that return true or false)
        //Based on the value that method return (true=> ModalProgressHUD is show) & (FALSE=> ModalProgressHUD is Don't show)
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Form(
          key: globalKey,
          child: ListView(
            children: <Widget>[
              BuyitLogo(heightScreen: heightScreen),
              SizedBox(
                height: heightScreen * .09,
              ),
              CustomTextField(
                onClick: (value) {
                },
                hint: 'Enter Your Name',
                icon: Icons.account_circle,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                onClick: (value) {
                  _email = value;
                },
                hint: 'Enter Your Email',
                icon: Icons.email,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                onClick: (value) {
                  _password = value;
                },
                hint: 'Enter Your Password',
                icon: Icons.lock,
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 140),
                //important to show SnackBar
                //to get (context) which use in "Scaffold.of(context)" not context of "Widget build"
                child: Builder(
                  builder: (context) => FlatButton(
                    padding: EdgeInsets.all(12),
                    shape: StadiumBorder(),
                    child: Text(
                      'Sign UP',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    color: Colors.black,
                    onPressed: () async {
                      //"listen: false" in Provider very important  To avoid ERROR
                      final modelhud =
                          Provider.of<ModelHud>(context, listen: false);
                      //control "ModalProgressHUD" when show or hide by use provider (has method that return true or false)
                      modelhud.changeisLoading(true);
                      if (globalKey.currentState.validate()) {
                        globalKey.currentState.save();
                        print(_email);
                        print(_password);
                        try {
                          final authResult =
                              await _auth.signUp(_email.trim(), _password.trim());
                          // if emil true hide it before go to HomePage
                          modelhud.changeisLoading(false);
                          Navigator.pushNamed(context, HomePage.id);
                          print(authResult.user.uid);
                          //on PlatformException before catch to show element in e.(...) + =>can use without it
                        } on PlatformException catch (e) {
                          //before shoe snack hide it
                          modelhud.changeisLoading(false);
                          print(e.toString());
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                              //to show mean of error to user not all error (to understand it)
                              e.message, style: TextStyle(color: Colors.red),
                            ),
                          ));
                        }
                      }
                      //if all of this code in try or catch not run "ModalProgressHUD" don't show
                      modelhud.changeisLoading(false);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: heightScreen * .10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "You have an account? ",
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1.2,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                          decorationStyle: TextDecorationStyle.solid),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
