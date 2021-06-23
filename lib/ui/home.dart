
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galleryapp/DataModel/AlbumModel.dart';
import 'package:galleryapp/DataModel/ImageModel.dart';
import 'package:galleryapp/Provider/ProviderData.dart';
import 'package:galleryapp/SqLite/SQDataBase.dart';
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
  // ignore: non_constant_identifier_names
  AlbumData() async {
    try {
      var response =
      await Dio().get('https://jsonplaceholder.typicode.com/albums');
      if (response.statusCode == 200) {
        return (response.data as List).map((e) async {
         // print(e);
          AlbumModel albumData = AlbumModel(
            id: e[AlbumModelData.id],
            title: e[AlbumModelData.title],
            userId: e[AlbumModelData.userId],
          );
          SQDataBase.sqDataBase.listdataAddDb(albumData);
        }).toList();
      }
    } catch (e) {
      print('Album errors is ' + e.toString());
    }
  }

// ignore: non_constant_identifier_names
  ImageData() async {
    try {
      var response =
      await Dio().get('https://jsonplaceholder.typicode.com/photos');
      if (response.statusCode == 200) {
        return (response.data as List).map((e) async {
          // Uri myUri = Uri.parse(e[ImageModelData.thumbnailUrl]);
          // var image = await get(myUri);
          // print(image.body);
          // var bytes = image.bodyBytes;
          //print(e);
          ImageModel i = ImageModel(
              id: e[ImageModelData.id],
              albumId: e[ImageModelData.albumId],
              title: e[ImageModelData.title],
              thumbnailUrl: e[ImageModelData.thumbnailUrl],
              url: e[ImageModelData.url]);
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
    AlbumData();
    ImageData();
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
              icon:  Icon(Icons.home_max),
              title: Text('Home'),
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon:  Icon(Icons.image),
              title: Text('Image'),
              backgroundColor: Colors.blue,
            ),
          ],
        ));
  }
}
