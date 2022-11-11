import 'package:fitness_app/domain/exercise_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:synchronized/synchronized.dart';

class DBProvider {
  final String _tableName = "EXERCISES";
  static final DBProvider db = DBProvider._();
  DBProvider._();

  static bool? _hasData;
  static Database? _database;
  static Lock databaseLock = Lock();

  initDB() async {
    var path = await getDatabasePath();
    return await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      var createScript = StringBuffer();
      createScript.write("CREATE TABLE  ");
      createScript.write("        $_tableName ( ");
      createScript.write("            ID INTEGER PRIMARY KEY, ");
      createScript.write("            NAME TEXT,  ");
      createScript.write("            SET_COUNT INTEGER, ");
      createScript.write("            SET_REPEAT INTEGER, ");
      createScript.write("            WEIGHT NUMERIC(5,2), ");
      createScript.write("            WEIGHT_COUNT INTEGER ");
      createScript.write("         ) ");
      await db.execute(createScript.toString());
      _hasData = false;
    });
  }

  Future<String> getDatabasePath() async {
    String databasesPath = await getDatabasesPath();
    return join(databasesPath, "$_tableName.db");
  }

  Future<bool> insertItem(Map<String, dynamic> item) async {
    DatabaseExecutor executor = (await database) as DatabaseExecutor;
    return (await executor.insert(_tableName, item)) > 0;
  }

  Future<List<ExerciseModel>> getItems() async {
    DatabaseExecutor executor = (await database) as DatabaseExecutor;
    var result = await executor.rawQuery('SELECT * FROM $_tableName');

    return ExerciseModel.listFromJson(result);
  }

  void closeDatabase() {
    if (_database != null) {
      if (_database is Database) {
        _database!.close();
        _database = null;
      }
    }
  }

  //Getters
  Future<DatabaseExecutor?> get database async {
    await databaseLock.synchronized(() async {
      _database ??= await initDB();
    });
    return _database;
  }

  Future<Database?> get databaseForTransaction async {
    _database ??= await initDB();
    return _database;
  }

  bool get hasData => _hasData ?? false;
}
