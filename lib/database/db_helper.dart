// import 'package:financialcalc/models/calculation.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

import '../models/calculation.dart';

class DBHelper{
  // static final DBHelper _instance = DBHelper._internal();
  //
  // factory DBHelper() => _instance;
  // DBHelper._internal();
  // static Database? _database;

  static final DBHelper instance = DBHelper._init();
  static Database? _database;
  DBHelper._init();


  Future<Database> get database async{
    if (_database != null) return _database!;

    _database = await _initDB('calculations.db');
    return _database!;
  }

  Future<Database> _initDB(String filepath) async{

      final path = join(await getDatabasesPath(), 'calculations.db');

      return await openDatabase(path,
        version: 1,
        onCreate: (db, version) async{
        await db.execute('''CREATE TABLE calculations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        principal REAL,
        rate REAL,
        time REAL,
        result REAL,
        amount REAL,
        type TEXT
        )
        ''');
        // compound_frequency TEXT,
        //     created_at TEXT
        }
      );


  }

  Future<int> insertData(InterestData data) async{
    final db = await database;
    return await db.insert('calculations', data.toMap());
  }

  Future<int> deleteData(int id) async{
    final db = await database;
    return await db.delete(
      'calculations',
      where: 'id = ?',
      whereArgs: [id]
    );
  }

  Future<int> deleteAll() async{
    final db = await database;
    return await db.delete('calculations');
  }

  //Future<List<InterestData>> getAllCalculations() async{
  Future<List<Map<String, dynamic>>> getAllCalculations() async{
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('calculations'); //, orderBy: 'created_at DESC');

    return maps;
    // return List.generate(
    //   maps.length, (index){
    //   return InterestData.fromMap(maps[index]);
    // }
    // );
  }

  Future close() async{
    final db = await database;
    db.close();
  }

}

