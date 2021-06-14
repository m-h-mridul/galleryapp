import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class CustomSplashScreen extends StatefulWidget {
  CustomSplashScreen({
    required Key key,
  }) : super(key: key);

  @override
  _CustomSplashScreenState createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return  new SplashScreen(
        seconds: 1,
        //navigateAfterSeconds: HomeScreen(),
        image: new Image.asset('assets/images/splashscreen.png'),
        loadingText: Text('Loading..',style: TextStyle(fontSize: 18),),
        title: Text(
          'EVERY BLOOD \nDONOR IS A \nHERO',textScaleFactor: 2,
        ),
        backgroundColor: Colors.red,
        styleTextUnderTheLoader: TextStyle(fontFamily: 'Segoe UI',
          //fontSize: 20,
          color: const Color(0xff000000),
          fontWeight: FontWeight.w700,),
        photoSize: 140.0,
        loaderColor: Colors.black);
  }
}
