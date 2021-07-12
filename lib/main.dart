import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:galleryapp/ui/home.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'DataModel/AlbumModel.dart';
import 'DataModel/ImageModel.dart';
import 'Provider/ProviderData.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///SQDataBase.sqDataBase.database;
  Directory directory = await getApplicationDocumentsDirectory();
  print('directory ' + directory.toString());
  Hive.init(directory.path);
  Widget ans = await widgetreturn();
  await Future.delayed(Duration(seconds: 5));
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => ProviderData())],
    child: MaterialApp(debugShowCheckedModeBanner: false, home: ans),
  ));
}

Future<bool> get connectivityCheak async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    print('You are in wifi or internet connection.');
    return await Future<bool>.value(true);
  } else {
    print('Make sure wifi or internet connection');
    return await Future<bool>.value(false);
  }
}

// ignore: non_constant_identifier_names
ImageData() async {
  try {
    final box = await Hive.openBox('Image');
    var response =
        await Dio().get('https://jsonplaceholder.typicode.com/photos');
    if (response.statusCode == 200) {
      return (await response.data as List).map((e) async {
        ImageModel i = ImageModel.maptoimagemodel(e);
        box.add(i.toMap());
      }).toList();
    }
  } catch (e) {
    print('ImageGet errors is ' + e.toString());
  }
}

// ignore: non_constant_identifier_names
AlbumData() async {
  try {
    final box = await Hive.openBox('albume');
    var response =
        await Dio().get('https://jsonplaceholder.typicode.com/albums');
    if (response.statusCode == 200) {
      return (await response.data as List).map((e) async {
        // print("AlbumData add in dio ");
        AlbumModel albumData = AlbumModel.maptoalbummodel(e);
        box.add(albumData.toMap());
      }).toList();
    }
  } catch (e) {
    print('Album errors is ' + e.toString());
  }
}

widgetreturn() async {
  print('working start');
  bool bans = await connectivityCheak;
  try {
    if (bans) {
      await AlbumData();
      await ImageData();
      print('Connnection cheak');
      return MyHomePage(
        title: 'Gallery',
        ans: false,
      );
    }else{
      await Hive.openBox('albume');
      await Hive.openBox('Image');
      return MyHomePage(
        title: 'Gallery',
        ans: true,
      );
    }
  } catch (e) {
    print('Problem that is in cheak ui ' + e.toString());
  }
}
