import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galleryapp/DataModel/ImageModel.dart';
import 'package:galleryapp/SqLite/SQDataBase.dart';

class ImageShow extends StatefulWidget {
  const ImageShow({Key? key}) : super(key: key);

  @override
  _ImageShowState createState() => _ImageShowState();
}

class _ImageShowState extends State<ImageShow> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SQDataBase.sqDataBase.Imagedataget(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext ctx, int index) {
                  String uri =
                      snapshot.data[index][ImageModelData.url].toString();
                  return Center(child: Expanded(child: Image.network(uri)));
                });
          }
        });
  }
}
