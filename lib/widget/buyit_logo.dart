import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class BuyitLogo extends StatelessWidget {
  const BuyitLogo({
    Key key,
    @required this.heightScreen,
  }) : super(key: key);

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
              child: Image(
                height: 140,
                width: 140,
                image: AssetImage('img/icons/cart_icon.png'),
              ),
            ),
            Positioned(
              bottom: 0,
              left: MediaQuery.of(context).size.width * .43,
              // make text take 2 color
              child: Text(
                'Buy it',
                style: TextStyle(
                    foreground: Paint()
                      ..shader = ui.Gradient.linear(
                        const Offset(100, 60),
                        const Offset(150, 23),
                        <Color>[
//                          Colors.black,
                          Colors.grey,
                          Colors.grey,
//                          Color(0xff0052c2),

                        ],
                      ),
                    fontFamily: 'Pacifico',
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
