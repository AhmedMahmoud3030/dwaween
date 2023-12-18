import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../Models/FavModel.dart';

class DatabaseHelperFavourite{

  final String tableDuaaFav = 'tableFav';

  final String columnId = 'id';
  final String columNkName = 'kName';
  final String columnKText = 'kText';
  final String columNkNameT = 'kNameT';
  final String columnKTextT = 'kTextT';



  static Database? _db ;

  Future<Database?> get db async{
    if(_db != null){
      return _db ;
    }
    _db = await initDbDuaa();
    return _db;
  }

  initDbDuaa()async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath , 'notefav.db');
    var db = await openDatabase(path , version: 1 , onCreate: _onCreateDuaa);
    return db;
  }

  void _onCreateDuaa(Database db , int newVersion) async{
    var sql = 'CREATE TABLE $tableDuaaFav ($columnId INTEGER PRIMARY KEY,'
        '$columNkName TEXT,$columnKText TEXT,$columNkNameT TEXT,$columnKTextT TEXT)';
    await db.execute(sql);
  }

  Future<int> saveFav(FavModel duaaModel) async{
    var dbClient = await db;
    var result = await dbClient!.insert(tableDuaaFav , duaaModel.toMap() );
    return result;
  }

  Future<List> getAllFav() async{
    var dbClient = await db;
    var result = await dbClient!.query(
        tableDuaaFav ,
        orderBy: "$columnId DESC",
        columns: [columnId,columNkName,columnKText,columNkNameT,columnKTextT]
    );
    return result.toList();
  }

  Future<int?> getCountFav() async{
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient!.rawQuery('SELECT COUNT(*) FROM $tableDuaaFav'));
  }

  Future<FavModel?> getsFav(int id) async{
    var dbClient = await db;
    List<Map<String,dynamic>> result = await dbClient!.query(
        tableDuaaFav,
        columns: [columnId,columNkName,columnKText,columNkNameT,columnKTextT],where: '$columnId = ?',whereArgs: ['id']
    );

    if(result.isNotEmpty){
      return FavModel.fromMap(result.first);
    }

    return null;
  }

  Future<int> updateFav(FavModel duaaModel)async{
    var dbClient = await db;
    return await dbClient!.update(
        tableDuaaFav , duaaModel.toMap(), where: '$columnId = ?',whereArgs: [ duaaModel.id ]
    );
  }

  Future<int> deleteFav(int id)async{
    var dbClient = await db;
    return await dbClient!.delete(
        tableDuaaFav ,   where: '$columnId = ?',whereArgs: [id]
    );
  }

  Future  closeFav()async{
    var dbClient = await db;
    return await dbClient!.close();
  }




}