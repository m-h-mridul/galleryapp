import 'package:galleryapp/DataModel/AlbumModel.dart';
import 'package:galleryapp/DataModel/ImageModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQDataBase {
  static Database? _database;
  static final SQDataBase sqDataBase = SQDataBase._();

  SQDataBase._();

  database() async {
    if (_database == null) {
      _database = await creatDb();
      print(_database.toString());
    }
  }

  get cheakdataBase async {
    if (_database != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<Database> creatDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'gallery.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      final table = '''
          CREATE TABLE ${AlbumModelData.tableName}(
          ${AlbumModelData.userId} INTEGER NOT NULL,
          ${AlbumModelData.id} INTEGER NOT NULL, 
          ${AlbumModelData.title} TEXT NOT NULL
          )
          ''';
      final table2= '''
          CREATE TABLE ${ImageModelData.tablename}(
          ${ImageModelData.albumId} INTEGER NOT NULL,
          ${ImageModelData.id} INTEGER NOT NULL, 
          ${ImageModelData.title} TEXT NOT NULL,
          ${ImageModelData.thumbnailUrl} TEXT NOT NULL,
          ${ImageModelData.url} TEXT NOT NULL
          )
          ''';
      
      await db.execute(table);
      await db.execute(table2);
      // ignore: unnecessary_statements
      //db;
    });
  }

  imageAddDb(ImageModel values) async {
    try {
      var batch = _database!.batch();
      batch.insert(
        ImageModelData.tablename,
        values.toJson(),
      );
    } catch (e) {
      print('ImageModel Error is ' + e.toString());
    }
  }

  // ignore: non_constant_identifier_names
  listdataAddDb(Avalues) async {
    try {
      var batch = _database!.batch();
      batch.insert(
        AlbumModelData.tableName,
        Avalues.toJson(),
      );
    } catch (e) {
      print('AlbumModel Error is ' + e.toString());
    }
  }

  // ignore: non_constant_identifier_names
  Future<List<Map<String, dynamic>>> Imagedataget() async {
    var d = await _database!.query(ImageModelData.tablename);
     print('Image data '+d.toString());
    return d;
  }

  Future<List<Map<String, dynamic>>> listdataget() async {
    var d = await _database!.query(AlbumModelData.tableName);
    print('List data '+d.toString());
    return d;
  }
}
