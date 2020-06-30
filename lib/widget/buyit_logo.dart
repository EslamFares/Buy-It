import 'package:flutter/material.dart';

class BuyitLogo extends StatelessWidget {
  const BuyitLogo({
    Key key,
    @required this.heightScreen,
  }) : super(key: key);

  final int heightScreen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: heightScreen * .08),
      child: Container(
//            margin: EdgeInsets.only(top: heightScreen * .08),
        height: heightScreen * .2,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Hero(
              tag: 'hero',
              child: Image(
                image: AssetImage('img/icons/buyicon.png'),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Text(
                'Buy it',
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 25,
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
