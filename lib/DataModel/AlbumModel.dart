import 'package:hive/hive.dart';
//part 'AlbumModel.g.dart';


@HiveType(typeId: 0)
class AlbumModel {
  @HiveField(0)
  int? userId;
  @HiveField(1)
  int? id;
  @HiveField(2)
  String? title;

   AlbumModel({required this.userId, required this.id, required this.title});

  factory AlbumModel.maptoalbummodel(Map<dynamic, dynamic> jsonMake) {
    return AlbumModel(
        id: jsonMake[AlbumModelData.id],
        userId: jsonMake[AlbumModelData.userId],
        title: jsonMake[AlbumModelData.title],
      );
  }

  Map<String, dynamic> toMap() {
    return {'userId': this.userId, 'id': this.id, 'title': this.title};
  }
}

class AlbumModelData {
  static final String tableName = 'listdata';
  static final String userId = 'userId';
  static final String id = 'id';
  static final String title = 'title';
}
