// import 'package:financialcalc/models/interest_calculation.dart';
import 'package:financial_calculator/models/sip_calculation.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

import '../models/EMI_calculation.dart';
import '../models/interest_calculation.dart';
import '../models/lumpsum_calculation.dart';
import '../models/swp_calculation.dart';

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
        // version: 1,
          version: 6,
        onUpgrade: (db, oldVersion, newVersion) async{

        if (oldVersion < 2){
          // Add a new table for verion 2
          await db.execute('''
          CREATE TABLE IF NOT EXISTS sip_calculations (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          investment REAL,
          time REAL,
          expected_returns REAL,
          futureValue REAL,
          totalInvested REAL,
          estimatedReturns REAL
          )
          ''');
        }

        if (oldVersion < 3){
          await db.execute('''ALTER TABLE sip_calculations ADD COLUMN type TEXT;''');
        }
        if (oldVersion < 4){

          // // Added a column type in version 3
          // // await db.execute('ALTER TABLE sip_calculations ADD COLUMN IF NOT EXISTS type TEXT;');
          // var result = await db.rawQuery('''PRAGMA table_info(sip_calculations);''');
          // // checking if type column exists
          // bool typeColumnExists = result.any((column) => column['name'] == 'type');
          // if (!typeColumnExists){
          //
          // }

          // Added another table in version 4
          await db.execute('''
          CREATE TABLE IF NOT EXISTS lumpsum_calculations (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          investment REAL,
          returns REAL,
          duration REAL,
          futureValue REAL,
          type TEXT)
          ''');
        }

        // Version 5
          if (oldVersion < 5){
            await db.execute('''CREATE TABLE IF NOT EXISTS swp_calculations (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            lumpsum REAL,
            rate REAL,
            monthly_withdrawl REAL,
            time REAL,
            
            totalWithdrawn REAL,
            remaining REAL,
            type TEXT
            
            )''');
          }

          // Version 6
          if (oldVersion < 6){
            await db.execute('''CREATE TABLE IF NOT EXISTS emi_calculations (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            amount REAL,
            rate REAL,
            months INT, 
            monthlyPayment REAL,
            totalRepayment REAL,
            totalInterest REAL,
            type TEXT
            )''');
          }


        },
        onCreate: (db, version) async{


        // CREATED TABLE calculations
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


          // CREATED TABLE SIP_CALCULATIONS

          await db.execute('''CREATE TABLE sip_calculations (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          investment REAL,
          time REAL,
          expected_returns REAL,
          futureValue REAL,
          totalInvested REAL,
          estimatedReturns REAL
          type TEXT
          )''');


          // CREATE TABLE Lumpsum Calculations

          await db.execute('''CREATE TABLE lumpsum_calculations(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          investment REAL, 
          returns REAL,
          duration REAL,
          futureValue REAL,
          type TEXT)''');



          // CREATE TABLE SWP CALCULATIONS
        await db.execute('''CREATE TABLE IF NOT EXISTS swp_calculations (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            lumpsum REAL,
            rate REAL,
            monthly_withdrawl REAL,
            time REAL,
            
            totalWithdrawn REAL,
            remaining REAL,
            type TEXT
            
            )''');

        await db.execute('''CREATE TABLE IF NOT EXISTS emi_calculations (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            amount REAL,
            rate REAL,
            months INT, 
            monthlyPayment REAL,
            totalRepayment REAL,
            totalInterest REAL,
            type TEXT
            )''');

        }
      );
  }

  Future<List<String>> getAllTables() async{
    final db = await database;
    final List<Map<String, dynamic>> tables = await db.query('sqlite_master',
    where : 'type = ?',
      whereArgs: ['table']
    );
    return tables.map((e) => e['name'] as String).toList();
  }

  Future<List<String>> getTableColumns(Database db, String tableName) async {
    final result = await db.rawQuery('PRAGMA table_info($tableName)');

    // Extract the 'name' field from each column
    List<String> columnNames = result.map((col) => col['name'] as String).toList();

    return columnNames;
  }


  // Insert data for SI CI Calculations
  Future<int> insertData(InterestData data) async{
    final db = await database;
    return await db.insert('calculations', data.toMap());
  }

  // Insert data for SIP Calculations
  Future<int> insertDataSIP(SIPCalculationData data) async{
    final db = await database;
    return await db.insert('sip_calculations', data.toMap());
  }

  Future<int> insertDataSWP(SWPCalculationData data) async{
    final db = await database;
    return await db.insert('swp_calculations', data.toMap());
  }

  Future<int> insertDataLumpsum(LumpsumData data) async{
    final db = await database;
    return await db.insert('lumpsum_calculations', data.toMap());
  }

  Future<int> insertDataEMI(EMIData data) async{
    final db = await database;
    return await db.insert('emi_calculations', data.toMap());
  }


  Future<int> deleteData(int id, String table) async{
    final db = await database;
    return await db.delete(table, where : 'id = ?', whereArgs:  [id]);
  }

  // Future<int> deleteData(int id) async{
  //   final db = await database;
  //   return await db.delete(
  //     'calculations',
  //     where: 'id = ?',
  //     whereArgs: [id]
  //   );
  // }
  //
  // Future<int> deteleDataSIP(int id) async{
  //   final db = await database;
  //   return await db.delete(
  //     'sip_calculations',
  //     where : "id = ?",
  //     whereArgs: [id]
  //   );
  // }

  Future<int> deleteAll() async{
    final db = await database;
    // return await db.delete('calculations');
    int count1 = await db.delete('calculations');
    int count2 = await db.delete('sip_calculations');
    int count3 = await db.delete('lumpsum_calculations');
    int count4 = await db.delete('swp_calculations');
    int count5 = await db.delete('emi_calculations');
    return count1 + count2 + count3 + count4;
  }

  //Future<List<InterestData>> getAllCalculations() async{
  Future<List<Map<String, dynamic>>> getAllCalculations() async{
    final db = await database;

    // find all the tables in the db. And query all the tables.
    // orderby _created at DESC

    // WORKING
    // final List<Map<String, dynamic>> maps = await db.query('calculations'); //, orderBy: 'created_at DESC');

    final List<Map<String, dynamic>> calculation_maps = await db.rawQuery('SELECT * FROM  calculations;');
    final List<Map<String, dynamic>> sip_maps = await db.rawQuery('SELECT * FROM sip_calculations');
    final List<Map<String, dynamic>> lumpsum_maps = await db.rawQuery('SELECT * FROM lumpsum_calculations');
    final List<Map<String, dynamic>> swp_maps = await db.rawQuery('SELECT * FROM swp_calculations');
    final List<Map<String, dynamic>> emi_maps = await db.rawQuery('SELECT * from emi_calculations');
    final List<Map<String, dynamic>> maps = [...calculation_maps, ...sip_maps, ...lumpsum_maps, ...swp_maps, ...emi_maps];
    // print(maps);

    // print(getTableColumns(db, 'swp_calculations'));
    // final columns_swp = await getTableColumns(db, 'swp_calculations');
    // print(columns_swp);
    // print("SWP MAPS $swp_maps");
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

