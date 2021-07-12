import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galleryapp/DataModel/AlbumModel.dart';
import 'package:hive/hive.dart';

// ignore: camel_case_types
class listShow extends StatelessWidget {
  const listShow({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final data = Hive.box('albume');
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          //AlbumModel albumModel=AlbumModel.fromJson(snapshot.data[index]);
          final seconddt = data.get(index);
          AlbumModel albumModel = AlbumModel.maptoalbummodel(seconddt);
          //print('hive data is ' + seconddt.toString());
          return Card(
            child: ListTile(
              tileColor:Colors.amber,
              title: Text(albumModel.id.toString() +
                  ' ---> USER Id :' +
                  albumModel.userId.toString()),
              isThreeLine: true,
              subtitle: Text(albumModel.title.toString()),
              // title: Text((list == null)?'loading':list![index]['title'].toString()),
            ),
          );
        });
  }
}
