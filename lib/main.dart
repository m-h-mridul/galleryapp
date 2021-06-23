import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:galleryapp/ui/home.dart';
import 'package:provider/provider.dart';
import 'Nowif.dart';
import 'Provider/ProviderData.dart';
import 'SqLite/SQDataBase.dart';

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
    Future<bool?> ans = connectivityCheak();
    SQDataBase.sqDataBase.database();
    // ignore: unrelated_type_equality_checks
    Widget ans2 = (ans != true)
        ? MyHomePage(
            title: 'Mridul',
          )
        : NOwifi();
    return MaterialApp(debugShowCheckedModeBanner: false, home: ans2);
  }

  Future<bool?> connectivityCheak() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    try {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        print('I am connected to a mobile/wifi network.');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
