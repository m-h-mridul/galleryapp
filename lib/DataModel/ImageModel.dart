class ImageModel {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  ImageModel({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      ImageModel(
        albumId: json['albumId'],
        id: json['id'],
        title: json['title'],
        url: json['url'],
        thumbnailUrl: json['thumbnailUrl'],
      );

  Map<String, dynamic> toJson() {
    return {
      'albumId': this.albumId,
      'id': this.id,
      'title': this.title,
      'url': this.url,
      'thumbnailUrl': this.thumbnailUrl
    };
  }
}
class ImageModelData{
  static String albumId='albumId';
  static String id='id';
  static String title='title';
  static String url='url';
  static String thumbnailUrl='thumbnailUrl';
  static String tablename='imagedata';
}
