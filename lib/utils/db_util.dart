import 'package:fitness_app/domain/exercise_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:synchronized/synchronized.dart';

enum DBOperationType { SAVE, DELETE }

class DBUtil {
  final String _tableName = "EXERCISES";
  static final DBUtil db = DBUtil._();
  DBUtil._();

  static Database? _database;
  static Lock databaseLock = Lock();

  initDB() async => await openDatabase(
        (await databasePath),
        version: 1,
        onCreate: (db, version) async => await db.execute(createScript),
      );

  Future<bool> makeOperation({ExerciseModel? item, DBOperationType type = DBOperationType.SAVE}) async {
    if (item == null) return false;
    switch (type) {
      case DBOperationType.SAVE:
        return await _saveItem(item);
      case DBOperationType.DELETE:
        return await _delete(item);
      default:
        return false;
    }
  }

  Future<bool> _saveItem(ExerciseModel item) async {
    late bool success;
    if (item.id == null) {
      var id = await _insert(item);
      if (id != 0) {
        item.id = id;
        success = true;
      }
    } else
      success = await _update(item);
    return success;
  }

  Future<int> _insert(ExerciseModel item) async {
    DatabaseExecutor executor = (await database) as DatabaseExecutor;
    return (await executor.insert(_tableName, item.toJson()));
  }

  Future<bool> _delete(ExerciseModel item) async {
    DatabaseExecutor executor = (await database) as DatabaseExecutor;
    return (await executor.rawDelete("DELETE FROM $_tableName where ID = ${item.id}")) > 0;
  }

  Future<bool> _update(ExerciseModel item) async {
    DatabaseExecutor executor = (await database) as DatabaseExecutor;
    return (await executor.update(_tableName, item.toJson(), where: 'ID = ?', whereArgs: [item.id])) > 0;
  }

  Future<List<ExerciseModel>> getItems() async {
    DatabaseExecutor executor = (await database) as DatabaseExecutor;
    var result = await executor.rawQuery('SELECT * FROM $_tableName');
    return ExerciseModel.listFromJson(result);
  }

  void closeDatabase() {
    if (_database != null && _database is Database) {
      _database!.close();
      _database = null;
    }
  }

  //Getters
  Future<DatabaseExecutor?> get database async {
    await databaseLock.synchronized(() async => _database ??= await initDB());
    return _database;
  }

  Future<String> get databasePath async => join((await getDatabasesPath()), "$_tableName.db");

  String get createScript => (StringBuffer()
        ..write("CREATE TABLE  ")
        ..write("        $_tableName ( ")
        ..write("            ID INTEGER PRIMARY KEY, ")
        ..write("            NAME TEXT,  ")
        ..write("            SET_COUNT INTEGER, ")
        ..write("            SET_REPEAT INTEGER, ")
        ..write("            WEIGHT NUMERIC(5,2), ")
        ..write("            WEIGHT_COUNT INTEGER ")
        ..write("         ) "))
      .toString();
}
