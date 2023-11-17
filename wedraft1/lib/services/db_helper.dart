import '../models/db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Users2.db";

  static final table = 'User';
  static final columnUsername = 'username';
  static final columnPassword = 'password';
  static final columnContact1 = 'contact1';
  static final columnContact2 = 'contact2';
  static final columnContact3 = 'contact3';
  static final columnnUser = 'curruser';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE User(id INTEGER PRIMARY KEY, username TEXT NOT NULL, password TEXT NOT NULL, contact1 TEXT NOT NULL, contact2 TEXT, contact3 TEXT, curruser INTEGER);"),
        version: _version);
  }

  static Future<void> unCurr() async {
    final db = await _getDB();
    return await db.execute("UPDATE User SET curruser=0 WHERE curruser=1");
  }

  static Future<int> addUser(User user) async {
    final db = await _getDB();
    return await db.insert("User", user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateUser(List<String> lst) async {
    final db = await _getDB();
    /*return await db.update("User", user.toJson(),
        where: 'id = ?',
        whereArgs: [user.id],
        conflictAlgorithm: ConflictAlgorithm.replace);*/
    return await db.rawUpdate('''
    UPDATE USER 
    SET username = ?, password = ?, contact1 = ?, contact2 = ?, contact3 = ?
    WHERE curruser = 1
    ''',
        lst);
  }


  static Future<int> login(List<String> lst) async {
    final db = await _getDB();
    /*return await db.update("User", user.toJson(),
        where: 'id = ?',
        whereArgs: [user.id],
        conflictAlgorithm: ConflictAlgorithm.replace);*/
    return await db.rawUpdate('''
    UPDATE USER 
    SET curruser=1
    WHERE username = ? AND password = ?
    ''',
        lst);
  }




  static Future<List<String>> getData() async {
    final db = await _getDB();
    final lst = List<String>.filled(5, "0");
    List<String> columnsToSelect = [
      DatabaseHelper.columnUsername,
      DatabaseHelper.columnPassword,
      DatabaseHelper.columnContact1,
      DatabaseHelper.columnContact2,
      DatabaseHelper.columnContact3,
    ];
    String whereString = '${DatabaseHelper.columnnUser} = 1';
    int rowId = 1;
    List<dynamic> whereArguments = [rowId];

    // lst[0]=await db.query(DatabaseHelper.table,columns: DatabaseHelper.columnUsername,where:whereString);
//var result=Map<String,String>();
    List<Map> result = await db.query(
        DatabaseHelper.table,
        columns: columnsToSelect,
        where: whereString);
    // print the results
    /*lst[0]=result[0][0].toString();
  lst[1]=result[0][1].toString();
  lst[2]=result[0][2].toString();
  lst[3]=result[0][3].toString();
  lst[4]=result[0][4].toString();
  print(lst[0]);
  print(lst[1]);
  print(lst[2]);
  print(lst[3]);
  print(lst[4]);*/
    //print(result[0][0]);
    int i=0;
    //result.forEach((row) => print(row));
    for(var key in result[0].values)
    {
      lst[i]=key;
      i=i+1;
    }
    // print(lst[0]);
    // print(lst[1]);
    // print(lst[2]);
    // print(lst[3]);
    // print(lst[4]);

    return lst;
    /*return await db.update("User", user.toJson(),
        where: 'id = ?',
        whereArgs: [user.id],
        conflictAlgorithm: ConflictAlgorithm.replace);*/
    /*return await db.rawUpdate('''
    UPDATE USER
    SET curruser=1
    WHERE username = ? AND password = ?
    ''',
    lst);*/
  }

  static Future<int> deleteUser(User user) async {
    final db = await _getDB();
    return await db.delete(
      "User",
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  static Future<List<User>?> getAllUsers() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("User");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => User.fromJson(maps[index]));
  }
}