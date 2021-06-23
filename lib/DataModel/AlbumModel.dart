
class AlbumModel {
  int ?userId;
  int ?id;
  String ?title;

  AlbumModel({required this.userId, required this.id, required this.title});

  factory AlbumModel.fromJson(Map<String, dynamic> jsonMake) => AlbumModel(
        id: jsonMake['id'],
        userId: jsonMake['userId'],
        title: jsonMake['title'],
      );

  Map<String, dynamic> toJson() {
    return {'userId': this.userId, 'id': this.id, 'title': this.title};
  }
}

class AlbumModelData {
  static String tableName = 'listdata';
  static String userId = 'userId';
  static String id = 'id';
  static String title = 'title';
}
