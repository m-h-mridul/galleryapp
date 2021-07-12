import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Gallery'),
        ),
        body: Center(
          child: Container(
            child: Image.asset('asset/images/nointernet.png'),
          ),
        ),
      ),
    );
  }
}
