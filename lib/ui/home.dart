import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galleryapp/DataModel/ImageModel.dart';
import 'package:galleryapp/Provider/ProviderData.dart';
import 'package:galleryapp/SqLite/SQDataBase.dart';
import 'package:provider/provider.dart';
import 'ImageUi.dart';
import 'listview.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  var provider;
    final tabs=[
      listview(),
      Grideview(),
    ];
  // ignore: non_constant_identifier_names
  ImageDataGet() async {
    try {
       var response =
      await Dio().get('https://jsonplaceholder.typicode.com/photos');
      if (response.statusCode == 200) {
        return (response.data as List).map((e) {
          ImageModel i=ImageModel(
            id: e[ImageModelData.id],
            albumId:e[ImageModelData.albumId],
            title: e[ImageModelData.title],
            thumbnailUrl: e[ImageModelData.thumbnailUrl],
            url: e[ImageModelData.url]
          );
         SQDataBase.sqDataBase.imageAddDb(i);
        }).toList();
      }
    } catch (e) {
      print('ImageGet errors is ' + e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ProviderData>(context);
    ImageDataGet();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: SafeArea(
          child: (provider.albumData==null)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              :tabs[provider.pageSet],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index){
            provider.pageSet=index;
          },
          currentIndex: 0, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.image),
              title: new Text('Image'),
            ),
          ],
        ));
  }
}
