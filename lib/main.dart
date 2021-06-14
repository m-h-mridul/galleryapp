import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:galleryapp/DataModel/ImageModel.dart';
import 'package:galleryapp/ui/home.dart';
import 'package:provider/provider.dart';
import 'Provider/ProviderData.dart';
import 'SqLite/SQDataBase.dart';

var provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => ProviderData())],
    child: Home(), // MaterialApp(debugShowCheckedModeBanner: false, home: ),
  ));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ProviderData>(context);
    //print('Called method');
    connectivityCheak();
    AlbumData();
   // ImageDataGet();
    return MaterialApp(
        home: MyHomePage(
      title: 'Mridul',
    ));
  }


  Future<void> connectivityCheak() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    try {
      if (connectivityResult == ConnectivityResult.mobile) {
        //print('I am connected to a mobile network.');
      } else if (connectivityResult == ConnectivityResult.wifi) {
        //print('I am connected to a wifi network.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

// ignore: non_constant_identifier_names
  AlbumData() async {
    try {
      var response =
          await Dio().get('https://jsonplaceholder.typicode.com/albums');
      if (response.statusCode == 200) {
       // print('Success in AlbumData');
        provider.albumData = await response.data;
      }
    } catch (e) {
      print('Album errors is ' + e.toString());
    }
  }

// ignore: non_constant_identifier_names
  ImageDataGet() async {
    try {
      var response =
          await Dio().get('https://jsonplaceholder.typicode.com/photos');
      if (response.statusCode == 200) {
        print("after in sent item in sql");
       // print('Success in imageData');
        //  var c= (await response.data as List).map((e) {
        //   print('db item ' + e.toString());
        //   SQDataBase.sqDataBase.imageAddDb(ImageModel.fromJson(e));
        // });
      }
    } catch (e) {
      print('ImageGet errors is ' + e.toString());
    }
  }
}
