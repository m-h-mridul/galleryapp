import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galleryapp/DataModel/ImageModel.dart';
import 'package:galleryapp/SqLite/SQDataBase.dart';

class Grideview extends StatefulWidget {
  const Grideview({Key? key}) : super(key: key);

  @override
  _GrideviewState createState() => _GrideviewState();
}

class _GrideviewState extends State<Grideview> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SQDataBase.sqDataBase.Imagedataget(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else if (snapshot.hasError) {
            return Center(
                child: Text(
              snapshot.hasError.toString(),
              style: TextStyle(
                fontSize: 16,
              ),
            ));
          } else {
            return GridView.builder(
              primary: false,
              padding: const EdgeInsets.all(10),
              itemCount: snapshot.data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),

              itemBuilder: (BuildContext context, int index) {
                String thumbnaiUrl = snapshot.data[index]
                        [ImageModelData.thumbnailUrl]
                    .toString();
                //provider.imageData![index]['thumbnailUrl'].toString();
                String id = snapshot.data[index][ImageModelData.id].toString();
                //provider.imageData![index]['id'].toString();
                String title =
                    snapshot.data[index][ImageModelData.title].toString();
                String uri =
                    snapshot.data[index][ImageModelData.url].toString();
                //provider.imageData![index]['title'].toString();
                return Card(
                  color: Colors.green,
                  child: Column(
                    children: [
                      ///Flexible(flex:2,child: Image.network(thumbnaiUrl)),
                      Text(id + ' ' + title),
                      Text(uri),
                      Text(thumbnaiUrl),
                      // Image.memory(base64Decode(thumbnaiUrl),
                      //     fit: BoxFit.fill,),
                    ],
                  ),
                );
              },
            );
          }
        });
  }
}
