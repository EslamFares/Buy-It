import 'package:buyit_ecommerce_app/colors.dart';
import 'package:buyit_ecommerce_app/screens/signup_screen.dart';
import 'package:buyit_ecommerce_app/services/auth.dart';
import 'package:buyit_ecommerce_app/widget/buyit_logo.dart';
import 'package:buyit_ecommerce_app/widget/custom_textfeild.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'LoginScreen';
  String _email,_password;
  final _auth = Auth();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
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
              height: heightScreen * .15,
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
                  'Login',
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                color: Colors.black,
                onPressed: ()async {
                  if(globalKey.currentState.validate()){
                    globalKey.currentState.save();
                   final result= await _auth.signIn(_email, _password);
                   print(result.user.uid);
                  }
                },
              ),
            ),
            SizedBox(
              height: heightScreen * .19,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Don't have an account? ",
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, SignUPScreen.id);
                  },
                  child: Text(
                    "Sign Up",
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
