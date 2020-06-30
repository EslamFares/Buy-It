import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuyitLogo extends StatelessWidget {
  const BuyitLogo({Key key, @required this.heightScreen,}) : super(key: key);

  final int heightScreen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: heightScreen * .05),
      child: Container(
//        margin: EdgeInsets.only(top: heightScreen * .08),
        height: heightScreen * .29,
//        color: Colors.pink,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Hero(
              tag: 'hero',
              child: Image(height: 140,width: 140,
                image: AssetImage('img/icons/cart_icon.png'),
              ),
            ),

            Positioned(
              bottom: 0,
              left: MediaQuery.of(context).size.width*.43,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Buy' ,
                    style: TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color:Colors.black ,
                        letterSpacing: 1.5),
                  ),

                  Text(
                    'it',
                    style: TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff0052c2),//003481
                        letterSpacing: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
