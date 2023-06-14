import 'dart:async';
import 'package:realtime_innovation/helper/HelperStrings.dart';
import 'package:realtime_innovation/models/ModelUser.dart';
import 'package:sqflite/sqflite.dart';

class UserRepo {
  // createUser this method we are using for adding new user in the database
  Future<int> createUser(Transaction txn, ModelUser user) async {
    var result = txn.insert(HelperStrings.table, user.toDatabaseJson());
    return result;
  }

  // For getting all the user from database we have created getAllUsers method
  Future<List<ModelUser>> getAllUsers(Transaction txn) async {
    List<Map<String, dynamic>> result;
    result = await txn.query(HelperStrings.table);
    List<ModelUser> listUsers = result.isNotEmpty
        ? result.map((item) => ModelUser.fromDatabaseJson(item)).toList()
        : [];
    return listUsers;
  }

  // For update any user info we have created this method
  Future<int> updateUser(Transaction txn, ModelUser user) async {
    var result = await txn.update(HelperStrings.table, user.toDatabaseJson(),
        where: "${HelperStrings.columnId} = ?", whereArgs: [user.id]);
    return result;
  }

  // TO delete any user we have created this method we just need to pass userId to this method then it will delete the user
  Future<int> deleteUser(Transaction txn, int id) async {
    var result = await txn.delete(HelperStrings.table,
        where: '${HelperStrings.columnId} = ?', whereArgs: [id]);
    return result;
  }
}
