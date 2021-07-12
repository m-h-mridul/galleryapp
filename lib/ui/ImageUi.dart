import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galleryapp/DataModel/ImageModel.dart';
import 'package:galleryapp/Provider/ProviderData.dart';
import 'package:galleryapp/ui/PicListView.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'NoInternet.dart';

class Grideview extends StatefulWidget {
  Grideview({Key? key}) : super(key: key);

  @override
  _GrideviewState createState() => _GrideviewState();
}

class _GrideviewState extends State<Grideview> {
  final box = Hive.box('Image');
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderData>(context);
    //  print("cheak Intertnet "+provider.cheakInternet.toString());
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        //crossAxisSpacing: 2.0,
        //mainAxisSpacing: 2.0,
      ),
      itemCount: box.length,
      itemBuilder: (BuildContext context, int index) {
        final data = box.get(index);
        // print('in image ui ' + data.toString());
        ImageModel imageModel = ImageModel.maptoimagemodel(data);
        return InkWell(
          onTap: () {
            print('click in image view');
            if (provider.cheakInternet.toString() == 'true') {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NoInternet()));
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PicListView(index)));
            }
          },
          child: Column(children: [
            Expanded(
              child: Card(
                child: CachedNetworkImage(
                  imageUrl: imageModel.thumbnailUrl.toString(),
                  placeholder: (context, url) =>
                      Center(child: new CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Center(
                    child: Image.asset('asset/images/nointernet.png'),
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            //Expanded(child: Text(imageModel.title.toString())),
          ]),
        );
      },
    );
  }
}
