import 'package:buyit_ecommerce_app/colors.dart';
import 'package:buyit_ecommerce_app/provider/modelHud.dart';
import 'package:buyit_ecommerce_app/screens/signup_screen.dart';
import 'package:buyit_ecommerce_app/services/auth.dart';
import 'package:buyit_ecommerce_app/widget/buyit_logo.dart';
import 'package:buyit_ecommerce_app/widget/custom_textfeild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'LoginScreen';
  String _email, _password;
  final _auth = Auth();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    int heightScreen = MediaQuery.of(context).size.height.toInt();
    int widthScreen = MediaQuery.of(context).size.width.toInt();
    return Scaffold(
      backgroundColor: KMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Form(
          key: globalKey,
          child: ListView(
            children: <Widget>[
              BuyitLogo(heightScreen: heightScreen),
              SizedBox(
                height: heightScreen * .15,
              ),
              CustomTextField(
                onClick: (value) {
                  _email = value;
                },
                hint: 'Enter Your Email',
                icon: Icons.email,
                hide: false,
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
                hide: true,
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 140),
                child: Builder(
                  builder:(context)=> FlatButton(
                    padding: EdgeInsets.all(12),
                    shape: StadiumBorder(),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    color: Colors.black,
                    onPressed: () async {
                      final modelhud = Provider.of<ModelHud>(context,listen: false);
                      modelhud.changeisLoading(true);
                      if (globalKey.currentState.validate()) {
                        try {
                          globalKey.currentState.save();
                          final result = await _auth.signIn(_email, _password);
                          modelhud.changeisLoading(false);
                          Navigator.pushNamed(context, HomeScreen.id);
                          print(result.user.uid);
                        }
                        on PlatformException catch (e) {
                          print(e.toString());
                          modelhud.changeisLoading(false);
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                              e.message
                            ),
                          ));
                        }
                      }
                      modelhud.changeisLoading(false);
                    },
                  ),
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
      ),
    );
  }
}
