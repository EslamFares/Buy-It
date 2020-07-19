import 'package:buyit_ecommerce_app/constants.dart';
import 'package:buyit_ecommerce_app/provider/Admin_mode.dart';
import 'package:buyit_ecommerce_app/provider/modelHud.dart';
import 'package:buyit_ecommerce_app/screens/signup_screen.dart';
import 'package:buyit_ecommerce_app/services/auth.dart';
import 'package:buyit_ecommerce_app/widget/buyit_logo.dart';
import 'package:buyit_ecommerce_app/widget/custom_textfeild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'admin/admin_home.dart';
import 'user/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;

  final _auth = Auth();

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  bool isAdmin = false;

  final adminPassword = 'Admin1234';

  bool keepMeLoggedIn=false;

  @override
  Widget build(BuildContext context) {
    int heightScreen = MediaQuery.of(context).size.height.toInt();
    return Scaffold(
      backgroundColor: kBackgroundUserColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Form(
          key: globalKey,
          child: ListView(
            children: <Widget>[
              BuyitLogo(heightScreen: heightScreen),
              SizedBox(
                height: heightScreen * .11,
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
                child: Builder(
                  builder: (context) => FlatButton(
                    padding: EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        side: BorderSide(color: Colors.white,width: 3)),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    color: kSecColor,
                    onPressed: () {
                      if(keepMeLoggedIn==true){KeepUserLoggedIn();}
                      _validate(context);
                    },
                  ),
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Theme(
                    data: ThemeData(unselectedWidgetColor: Colors.amber),
                    child: Checkbox(
                      activeColor: kSecColor,
                      checkColor: Colors.amber,
                      value: keepMeLoggedIn,
                      onChanged: (value){setState(() {
                        keepMeLoggedIn=value;
                      });},
                    ),
                  ),
                  Text('Remember me',style: TextStyle(color: Colors.white,fontSize: 14),),
                ],
              ),
              SizedBox(
                height: heightScreen * .09, //.19
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
                          color: Colors.amber,
                          letterSpacing: 1.2,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                          decorationStyle: TextDecorationStyle.solid),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                    Provider.of<AdminMode>(context, listen: false)
                        .changeIsAdmin(true);
                      },
                      child: Text(
                    'i\'m Admin',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color:
                            Provider.of<AdminMode>(context)
                                    .isAdmin
                                ? kBackgroundUserColor
                                : Colors.white),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                    Provider.of<AdminMode>(context, listen: false)
                        .changeIsAdmin(false);
                      },
                      child: Text(
                    'i\'m User',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color:
                            Provider.of<AdminMode>(context, listen: true)
                                    .isAdmin
                                ? Colors.white
                                : kBackgroundUserColor),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) async {
    final modelhud = Provider.of<ModelHud>(context, listen: false);
    modelhud.changeisLoading(true);
    if (globalKey.currentState.validate()) {
      globalKey.currentState.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (_password == adminPassword) {
          try {
            //trim() to remove eny spaces after email when user write to avoid error
            await _auth.signIn(_email.trim(), _password.trim());
            Navigator.pushNamed(context, AdminHome.id);
          } catch (e) {
            modelhud.changeisLoading(false);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(e.mesage),
            ));
          }
        } else {
          modelhud.changeisLoading(false);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('something went wrong !'),
          ));
        }
      } else {
        try {
          await _auth.signIn(_email, _password);
          Navigator.pushNamed(context, HomePage.id);
        } on PlatformException catch (e) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(e.message),
          ));
        }
      }
    }
    modelhud.changeisLoading(false);
  }

  void KeepUserLoggedIn()async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(kKeepMeLoggedIn, keepMeLoggedIn);
  }
}
