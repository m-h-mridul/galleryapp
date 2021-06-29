import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:galleryapp/ui/home.dart';
import 'package:provider/provider.dart';
import 'DataModel/AlbumModel.dart';
import 'DataModel/ImageModel.dart';
import 'Provider/ProviderData.dart';
import 'SqLite/SQDataBase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SQDataBase.sqDataBase.database;
  Future.delayed(Duration(minutes: 1));
  widgetreturn();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => ProviderData())],
    child: MaterialApp(
        debugShowCheckedModeBanner: false, home: MyHomePage(title: 'Gallery')),
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
    var response =
        await Dio().get('https://jsonplaceholder.typicode.com/photos');
    if (response.statusCode == 200) {
      return (await response.data as List).map((e) async {
        // Uri myUri = Uri.parse(e[ImageModelData.thumbnailUrl]);
        // var image = await get(myUri);
        // print(image.body);
        // var bytes = image.bodyBytes;
        //print(e);
        //print("Image data add in dio ");
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

// ignore: non_constant_identifier_names
AlbumData() async {
  try {
    var response =
        await Dio().get('https://jsonplaceholder.typicode.com/albums');
    if (response.statusCode == 200) {
      return (await response.data as List).map((e) async {
        // print("AlbumData add in dio ");
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

///
///AnimatedContainer(
//
//       duration: Duration(seconds: 4), color: Colors.green[300])
///
widgetreturn() async {
  var imagedata = await SQDataBase.sqDataBase.Imagedataget;
  var listData = await SQDataBase.sqDataBase.Listdataget;
  print('get data ' + imagedata.toString());
  bool ans = await connectivityCheak;
  try {
    // ignore: unnecessary_null_comparison
    if (imagedata.toString().length < 10 && listData.toString().length < 20) {
      if (ans) {
        await AlbumData();
        await ImageData();
        print('Connnection cheak');
        return true;
      } else {
        return false;
      }
    }
  } catch (e) {
    print('Problem that is in cheak ui ' + e.toString());
  }
}
