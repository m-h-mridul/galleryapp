import 'package:galleryapp/DataModel/AlbumModel.dart';
import 'package:galleryapp/DataModel/ImageModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQDataBase {
  static Database? _database;
  static final SQDataBase sqDataBase = SQDataBase._();

  SQDataBase._();

 Future<Database?> get database async {
    //print('database creat method call ');
    if (_database == null) {
    //  print('creatdb called');
      _database = await creatDb();
      return _database;
    }
    return _database;
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
      final table2 = '''
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
    });
  }

  imageAddDb(ImageModel values) async {
    try {
      final batch = await database;
      batch?.batch().insert(
        ImageModelData.tablename,
        values.toJson(),
      );
      //print('image  add ' + values.id.toString());
    } catch (e) {
      print('ImageModel Error is ' + e.toString());
    }
  }

  // ignore: non_constant_identifier_names
  listdataAddDb(AlbumModel Avalues) async {
    try {
      var batch = await database;
      batch?.batch().insert(
        AlbumModelData.tableName,
        Avalues.toJson(),
      );
      // print('List item add '+ Avalues.id.toString());
    } catch (e) {
      print('AlbumModel Error is ' + e.toString());
    }
  }

  // ignore: non_constant_identifier_names
  Future<List<Map<String, dynamic>>> get Imagedataget async {
    var db=await database;
    var list=await db!.query(ImageModelData.tablename);
    print(list);
    return list;
  }

  // ignore: non_constant_identifier_names
  Future<List<Map<String, dynamic>>> get Listdataget async{
    return  await _database!.query(AlbumModelData.tableName);
  }
      
}
