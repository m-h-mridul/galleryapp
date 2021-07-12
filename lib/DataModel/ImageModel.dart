
import 'package:hive/hive.dart';
//flutter packages pub run build_runner build
//part 'ImageModel.g.dart';

@HiveType(typeId: 1)
class ImageModel extends HiveObject {
  @HiveField(0)
  int? albumId;
  @HiveField(1)
  int? id;
  @HiveField(2)
  String? title;
  @HiveField(3)
  String? url;
  @HiveField(4)
  String? thumbnailUrl;

  ImageModel({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  factory ImageModel.maptoimagemodel(Map<dynamic, dynamic> json) => ImageModel(
        albumId: json['albumId'],
        id: json['id'],
        title: json['title'],
        url: json['url'],
        thumbnailUrl: json['thumbnailUrl'],
      );

  Map<String, dynamic> toMap() => {
        'albumId': this.albumId,
        'id': this.id,
        'title': this.title,
        'url': this.url,
        'thumbnailUrl': this.thumbnailUrl
      };

  
}

class ImageModelData {
  static final String albumId = 'albumId';
  static final String id = 'id';
  static final String title = 'title';
  static final String url = 'url';
  static final String thumbnailUrl = 'thumbnailUrl';
  static final String tablename = 'imagedata';
}
