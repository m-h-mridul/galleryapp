import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NOwifi extends StatelessWidget {
  const NOwifi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          'connected with mobile or wifi network',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
