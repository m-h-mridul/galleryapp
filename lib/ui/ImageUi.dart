
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
    List<ImageModel> l = [
      ImageModel(
          id: 1,
          thumbnailUrl: 'thumbale',
          url: 'url',
          title: 'name',
          albumId: 1),
      ImageModel(
          id: 1,
          thumbnailUrl: 'thumbale',
          url: 'url',
          title: 'name',
          albumId: 1),
    ];
    return FutureBuilder(
      future: SQDataBase.sqDataBase.Imagedataget(),
      builder: (BuildContext context,AsyncSnapshot snapshot){
        if(!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        else if(snapshot.hasError){
          return Center(child: Text(snapshot.hasError.toString(),style: TextStyle(
            fontSize: 16,
          ),));
        }
        else{
          // return Center(child: Text(snapshot.data.toString(),style: TextStyle(
          //   fontSize: 16,
          // ),));
          return GridView.builder(
            primary: false,
            padding: const EdgeInsets.all(10),
            itemCount: snapshot.data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
            itemBuilder: (BuildContext context, int index) {
              String thumbnaiUrl =snapshot.data[index][ImageModelData.thumbnailUrl];
              //provider.imageData![index]['thumbnailUrl'].toString();
              String id = snapshot.data[index][ImageModelData.id];
              //provider.imageData![index]['id'].toString();
              String title =snapshot.data[index][ImageModelData.title];
              String uri=snapshot.data[index][ImageModelData.url];
              //provider.imageData![index]['title'].toString();
              return Card(
                color: Colors.green,
                child: Column(
                  children: [
                    ///Flexible(flex:2,child: Image.network(thumbnaiUrl)),
                    Text(id+' '+title),
                    Text(uri),
                    Text(thumbnaiUrl),
                  ],
                ),
              );
            },
          );
        }
      }
    );
  }
}
