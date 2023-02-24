import 'dart:convert';

import 'package:wiliams/DataBase/Entity.dart';
import 'package:sqflite/sqflite.dart';

enum DbDataTypes {
  Integer,
  Text,
  Real,
}

typedef FromJsonFunction = BaseEntity Function(Map<String, dynamic> map);

abstract class BaseModel {
  static Database? _database;

  late String tablaName;

  Future<Database> get database async {
    _database ??= await initializedDataBase();

    String name = toString().replaceAll("Instance of '", '');
    name = name.replaceAll("'", '').trim();
    tablaName = name;
    // try {
    //   await this.count();
    // } catch (e) {
    //   await this._createDb(_database, 1);
    // }
    return _database!;
  }

  String primaryKey();

  Map<String, DbDataTypes> fields();

  Future<Database> initializedDataBase() async {
    var databasesPath = await getDatabasesPath();
    String name = toString().replaceAll("Instance of '", '');
    name = name.replaceAll("'", '').trim();
    tablaName = name;

    String path = '$databasesPath/$name';
    var db = await openDatabase(path, version: 1, onCreate: _createDb);
    return db;
  }

  Future<void> _createDb(Database db, int newVersion) async {
    String name = toString().replaceAll("Instance of '", '');
    name = name.replaceAll("'", '').trim();
    String query = "CREATE TABLE $tablaName";
    List fields = ['${primaryKey()} INTEGER PRIMARY KEY AUTOINCREMENT'];
    this.fields().forEach((key, value) {
      fields.add(
          "$key ${value.toString().replaceAll("DbDataTypes.", "").toUpperCase()}");
    });
    query = '$query (${fields.join(', ')} )';
    await db.execute(
      query,
    );
  }

  Future<void> createDb() async {
    Database database = await this.database;
    _createDb(database, 1);
  }

  Future<int> insert(Map<String, dynamic> map) async {
    Database db = await database;
    Map<String, dynamic> dataToAdd = {};
    map.forEach((key, value) {
      if (fields().containsKey(key)) {
        if (value is Map ||  value is Iterable ||
            value.runtimeType.toString().contains('_InternalLinkedHashMap') ||
            value.runtimeType.toString().contains('HashMap')) {
          dataToAdd[key] = jsonEncode(value);
        } else {
          dataToAdd[key] = value;
        }
      }
    });
    return db.insert(tablaName, dataToAdd);
  }

  Future<int> update(int id, Map<String, dynamic> map) async {
    Database db = await database;
    return db.update(tablaName, map, where: "${primaryKey()} = $id");
  }

  Future<List<int>> insertAll(List list) async {
    List<int> ids = [];
    list.forEach((element) async {
      ids.add(await insert(element));
    });
    return ids;
  }

  Future<void> truncate() async {
    Database db = await database;
    try {
      await db.rawDelete("delete from $tablaName");
    } catch (e) {
      await _createDb(db, 1);
      truncate();
    }
  }

  Future<List> getAll([FromJsonFunction? fromJson]) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      tablaName,
    );
    if (fromJson is FromJsonFunction) {
      return result.map((e) => fromJson(e)).toList();
    }
    return result.toList();
  }

  Future<BaseEntity?> get(FromJsonFunction fromJson, int id) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      tablaName,
      limit: 1,
      where: "${primaryKey()} = $id",
    );
    return result.isNotEmpty ? fromJson(result.first) : null;
  }

  Future<BaseEntity?> getFiltered(FromJsonFunction fromJson, String query, String OrderBy, String sortType, int limit, int offset) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      tablaName,
      limit: limit,
      offset: offset,
      where: "$query",
      orderBy: "$OrderBy $sortType",
    );
    return result.isNotEmpty ? fromJson(result.first) : null;
  }

  Future<int> delete(int id) async {
    Database db = await database;

    return await db.rawDelete(
      'DELETE FROM $tablaName WHERE ${primaryKey()} = $id',
    );
  }

  Future<bool> exists(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      tablaName,
      limit: 1,
      columns: [
        primaryKey(),
      ],
      where: "${primaryKey()} = $id",
    );
    return result.isNotEmpty;
  }

  Future<int?> count() async {
    Database db = await database;
    List<Map<String, dynamic>> x = await db.rawQuery(
      'SELECT COUNT (*) from $tablaName',
    );
    return Sqflite.firstIntValue(x);
  }
}
