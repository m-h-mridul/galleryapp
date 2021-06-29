
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galleryapp/Provider/ProviderData.dart';
import 'package:provider/provider.dart';
import 'ImageUi.dart';
import 'listShow.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  var provider;
    final tabs=[
      listShow(),
      Grideview(),
    ];
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ProviderData>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: SafeArea(
          child:tabs[provider.pageSet],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index){
            provider.pageSet=index;
          },
          currentIndex: 0, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon:  Icon(Icons.home),
              backgroundColor: Colors.green,
              label: "home",
            ),
            BottomNavigationBarItem(
              icon:  Icon(Icons.image,color: Colors.blue,),
              backgroundColor: Colors.blue[100],
              label: "image",
            ),
          ],
        ));
  }
}
