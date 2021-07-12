import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galleryapp/Provider/ProviderData.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'ImageUi.dart';
import 'listShow.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title, required this.ans})
      : super(key: key);
  final String title;
  final bool ans;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final _snackBar = SnackBar(content: Text('Please Cheak Internet Connection'));

  var provider;
  final tabs = [
    listShow(),
    Grideview(),
  ];
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    snakbar() {
      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
    }

    provider = Provider.of<ProviderData>(context);
    provider.cheakInternet=widget.ans;
    print("cheak Intertnet " + provider.cheakInternet.toString());
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: Container(
          child: tabs[provider.pageSet],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            if (widget.ans) {
              snakbar();
            }
            provider.pageSet = index;
          },
          currentIndex: 0, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.green,
              ),
              label: "home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.image,
                color: Colors.blue,
              ),
              backgroundColor: Colors.blue[100],
              label: "image",
            ),
          ],
        ));
  }
}
