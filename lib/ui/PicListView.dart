import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galleryapp/DataModel/ImageModel.dart';
import 'package:hive/hive.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

// ignore: must_be_immutable
class PicListView extends StatelessWidget {
  final int value;
  bool ans;
  PicListView(this.value, {Key? key, this.ans = true});

  @override
  Widget build(BuildContext context) {
    print('image number ' + value.toString());
    final box = Hive.box('Image');
    return Scaffold(
      appBar:  AppBar(
          centerTitle: true,
          title: Text('Gallery'),
        ),
      body: Container(
        color: Colors.white,
          child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              itemCount: box.length,
              loadingBuilder: (context, event) => Center(
                    child: Container(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(),
                    ),
                  ),
              //backgroundDecoration: widget.backgroundDecoration,
              pageController: PageController(initialPage: value),
              builder: (BuildContext context, index) {
                print('image number ' + index.toString());
                final data = box.get(index);
                ImageModel imageModel = ImageModel.maptoimagemodel(data);
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(imageModel.url.toString()),
                  initialScale: PhotoViewComputedScale.contained * 0.9,
                  heroAttributes:
                      PhotoViewHeroAttributes(tag: imageModel.title.toString()),
                );
              })),
    );
  }
}
