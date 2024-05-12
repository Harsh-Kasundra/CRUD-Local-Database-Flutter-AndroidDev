import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class MyDataBase {
  Future<Database> initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'MyDatabase.db'),
      version: 1,
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE Tbl_User(UserId INTEGER PRIMARY KEY AUTOINCREMENT,Name TEXT)');
      },
      onUpgrade: (db, oldVersion, newVersion) {},
    );
  }

  Future<int> insertRecordIntoUserTable(name) async {
    Database db = await initDatabase();
    Map<String, dynamic> map = {};
    map['Name'] = name;
    int userId = await db.insert('Tbl_User', map);
    return userId;
  }

  Future<int> updateUserDetailIntoUserTable(
      {required name, required userId}) async {
    Database db = await initDatabase();
    Map<String, dynamic> map = {};
    map['Name'] = name;
    return await db.update('Tbl_User', map, where: 'UserId = ?', whereArgs: [userId]);
  }

  Future<void> deleteUserFromUserTable({required userId}) async {
    Database db = await initDatabase();
    db.delete('Tbl_User',where: 'UserId = ?',whereArgs: [userId]);
  }

  Future<List<Map<String, dynamic>>> getUserListFromUserTbl() async {
    Database db = await initDatabase();
    List<Map<String, dynamic>> userList =
        await db.rawQuery('SELECT * FROM Tbl_User');
    return userList;
  }
}
