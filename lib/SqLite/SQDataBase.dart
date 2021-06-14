import 'package:galleryapp/DataModel/ImageModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQDataBase {
  static Database? _database;
  static final SQDataBase sqDataBase = SQDataBase._();

  SQDataBase._();

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await creatDb();
    return _database;
  }

  creatDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'albumData.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      final table = '''
          CREATE TABLE ${ImageModelData.tablename}(
          ${ImageModelData.albumId} INTEGER NOT NULL,
          ${ImageModelData.id} INTEGER NOT NULL, 
          ${ImageModelData.title} TEXT NOT NULL,
          ${ImageModelData.thumbnailUrl} TEXT NOT NULL,
          ${ImageModelData.url} TEXT NOT NULL
          )
          ''';
      //'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)'
      await db.execute(table);
    });
  }

  imageAddDb(ImageModel values) async {
    final db = await database;
    try {
      await db!.transaction((txn) => txn.insert(
        ImageModelData.tablename,
        values.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      ));
      Future.delayed(Duration(seconds: 1));
    } catch (e) {
      print('Error find store time' + e.toString());
    }
  }

  Future<List<Map<String, dynamic>>> Imagedataget() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =await db!.transaction((txn)=>txn.query(ImageModelData.tablename));
    print('Get data ans '+maps[0][ImageModelData.title].toString());
    return maps;
    // return  List.generate(maps.length, (i) {
    //   print("get data from sql");
    //   print(maps[i][ImageModelData.id].toString());
    //   return ImageModel(
    //     id: maps[i][ImageModelData.id],
    //     title: maps[i][ImageModelData.title],
    //     url: maps[i][ImageModelData.url],
    //     thumbnailUrl: maps[i][ImageModelData.thumbnailUrl],
    //   );
    // }).toList();
  }
}
