// import 'dart:io';

// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseHelper {
//   static const dbName = "myDatabase.db";
//   static const dbVersion = 1;
//   static const dbTable = "fav_list";
//   static const columnId = "id";
//   static const recordId = "recordid";
//   static const columnTitle = "title";
//   static const columnposterPath = "posterPath";
//   static const columnoverview = "overview";
//   static const columnreleaseDate = "releaseDate";

//   static final DatabaseHelper instance = DatabaseHelper();
//   static Database? _database;

//   // Future<Database?> get database async {
//   //   _database ??= await initDB();
//   //   return _database;
//   // }

//   Future<Database> get database async {
//     if (_database != null) return _database!;

//     _database = await initDB();
//     return _database!;
//   }

//   // initDB() async {
//   //   Directory directory = await getApplicationDocumentsDirectory();
//   //   String path = join(directory.path, dbName);
//   //   return await openDatabase(path, version: dbVersion, onCreate: onCreate);
//   // }

//   Future<Database> initDB() async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, dbName);

//     return await openDatabase(path, version: 1, onCreate: onCreate);
//   }

//   Future onCreate(Database db, int version) async {
//     db.execute('''
//     CREATE TABLE $dbTable(
//       $columnId INTEGER PRIMARY KEY,
//       $recordId TEXT NOT NULL
//       $columnTitle TEXT NOT NULL
//       $columnposterPath TEXT NOT NULL
//       $columnreleaseDate TEXT NOT NULL
//     )
    
//     ''');
//   }

//   inserRecord(Map<String, dynamic> row) async {
//     Database? db = await instance.database;
//     return await db!.insert(dbTable, row);
//   }

//   Future<List<Map<String, dynamic>>> queryDatabase() async {
//     Database? db = await instance.database;
//     return await db!.query(dbTable);
//   }

//   Future<int> updateRecord(Map<String, dynamic> row) async {
//     Database? db = await instance.database;
//     int id = row[columnId];
//     return await db!
//         .update(dbTable, row, where: '$columnId = ?', whereArgs: [id]);
//   }

//   Future deleteRecord(int id) async {
//     Database? db = await instance.database;
//     return await db!.delete(dbTable, where: '$columnId = ?', whereArgs: [id]);
//   }

//   Future<List<Map<String, dynamic>>> getqueryDatabase(id) async {
//     Database? db = await instance.database;
//     return await db!.query(dbTable, where: '$recordId = $id');
//   }
// }
