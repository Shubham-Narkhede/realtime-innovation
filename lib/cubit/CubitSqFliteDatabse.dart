import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:realtime_innovation/models/ModelUser.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../helper/HelperStrings.dart';
import '../repo/Repo.dart';

part 'StateSqFliteDatabase.dart';

class SqFlitDatabaseCubit extends Cubit<SqFliteDatabaseState> {
  SqFlitDatabaseCubit(this.userRepo) : super(StateInitial());
  UserRepo userRepo;

  /// this line is created for get the context or instance of this class
  static SqFlitDatabaseCubit get(context) => BlocProvider.of(context);

  /// database object we have initialize the open data
  late Database database;

  /// this init method is created for creating the database or table
  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, HelperStrings.databaseName);
    await openDatabase(path,
        version: HelperStrings.databaseVersion,
        onCreate: _onCreate, onOpen: (value) {
      database = value;
      getAllUser();
    }).then((value) {
      database = value;
    }).catchError((onError) {});
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE ${HelperStrings.table} (
            ${HelperStrings.columnId} INTEGER PRIMARY KEY,
            ${HelperStrings.columnName} TEXT NOT NULL,
            ${HelperStrings.columnRole} TEXT NOT NULL,
            ${HelperStrings.columnFromDate} TEXT NOT NULL,
            ${HelperStrings.columnToDate} TEXT NOT NULL
          )
          ''').then((value) {}).catchError((onError) {});
  }

  /// here we have created the method for getting all the operations like
  /// get, add, update and delete
  /// we are emitting the response on the basis of result
  getAllUser() async {
    emit(StateLoading());
    await database.transaction((txn) {
      return userRepo.getAllUsers(txn).then((value) {
        emit(StateSuccess(value));
      }).catchError((onError) {
        emit(StateError(onError.toString()));
      });
    });
  }

  /// when we are going to add user we are using this method for adding the user in database
  addUser(ModelUser user) async {
    await database.transaction((txn) {
      return userRepo.createUser(txn, user).then((value) {
        getAllUser();
      });
    });
  }

  /// to update ny user info we are created this method
  updateUserInfo(ModelUser user) async {
    await database.transaction((txn) {
      return userRepo.updateUser(txn, user).then((value) {
        getAllUser();
      }).onError((error, stackTrace) {});
    });
  }

  /// this method is created for delete the user
  deleteUser(int id) async {
    await database.transaction((txn) {
      return userRepo.deleteUser(txn, id).then((value) {
        getAllUser();
        emit(StateDeleted());
      });
    });
  }
}
