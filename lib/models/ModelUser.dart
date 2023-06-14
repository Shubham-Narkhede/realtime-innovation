import 'package:realtime_innovation/helper/HelperStrings.dart';

class ModelUser {
  int? id;
  String userName;
  String userRole;
  String fromDate;
  String toDate;

  ModelUser(
      {this.id,
      required this.userName,
      required this.userRole,
      required this.fromDate,
      required this.toDate});

  factory ModelUser.fromDatabaseJson(Map<String, dynamic> data) => ModelUser(
        id: data[HelperStrings.columnId],
        userName: data[HelperStrings.columnName],
        userRole: data[HelperStrings.columnRole],
        fromDate: data[HelperStrings.columnFromDate],
        toDate: data[HelperStrings.columnToDate],
      );

  Map<String, dynamic> toDatabaseJson() => {
        HelperStrings.columnId: id,
        HelperStrings.columnName: userName,
        HelperStrings.columnRole: userRole,
        HelperStrings.columnFromDate: fromDate,
        HelperStrings.columnToDate: toDate
      };
}
