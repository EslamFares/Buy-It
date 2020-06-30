import 'package:buyit_ecommerce_app/screens/login_screen.dart';
import 'package:buyit_ecommerce_app/widget/buyit_logo.dart';
import 'package:buyit_ecommerce_app/widget/custom_textfeild.dart';
import 'package:flutter/material.dart';
import 'package:buyit_ecommerce_app/services/auth.dart';
import '../colors.dart';

class SignUPScreen extends StatelessWidget {
  final GlobalKey<FormState> globalKey =GlobalKey<FormState>();
  static String id='signupscreen';
  String _email,_password;
  final _auth =Auth();
  @override
  Widget build(BuildContext context) {
    int heightScreen = MediaQuery.of(context).size.height.toInt();
    int widthScreen = MediaQuery.of(context).size.width.toInt();
    return Scaffold(
      backgroundColor: KMainColor,
      body: Form(
        key: globalKey,
        child: ListView(
          children: <Widget>[
            BuyitLogo(heightScreen: heightScreen),
            SizedBox(
              height: heightScreen * .09,
            ),
            CustomTextField(
              hint: 'Enter Your Name',
              icon: Icons.account_circle,
              hide: false,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onClick: (value){
                _email=value;
              },
              hint: 'Enter Your Email',
              icon: Icons.email,
              hide: false,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              onClick: (value){
                _password=value;
              },
              hint: 'Enter Your Password',
              icon: Icons.lock,
              hide: true,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 140),
              child: FlatButton(
                padding: EdgeInsets.all(12),
                shape: StadiumBorder(),
                child: Text(
                  'Sign UP',
                  style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                color: Colors.black,
                onPressed: () async{
                  if(globalKey.currentState.validate()){
                    //do task
                    globalKey.currentState.save();
                    print(_email);
                    print(_password);
                  final authResult= await  _auth.signUp(_email, _password);
                  print(authResult.user.uid);
                  }
                },
              ),
            ),
            SizedBox(
              height:heightScreen * .14,
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
    );
  }
}


