import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galleryapp/DataModel/AlbumModel.dart';
import 'package:galleryapp/SqLite/SQDataBase.dart';

// ignore: camel_case_types
class listShow extends StatelessWidget {
  const listShow({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SQDataBase.sqDataBase.Listdataget,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  String id =
                      snapshot.data[index][AlbumModelData.id].toString();
                  String userid =
                      snapshot.data[index][AlbumModelData.userId].toString();
                  String title =
                      snapshot.data[index][AlbumModelData.title].toString();
                  return Card(
                    color: Colors.amber,
                    child: ListTile(
                      title: Text(id + '->user Id :' + userid),
                      isThreeLine: true,
                      subtitle: Text(title),
                      // title: Text((list == null)?'loading':list![index]['title'].toString()),
                    ),
                  );
                });
          }
        });
  }
}
