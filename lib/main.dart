import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtime_innovation/cubit/CubitSqFliteDatabse.dart';
import 'package:realtime_innovation/repo/Repo.dart';
import 'package:realtime_innovation/screens/ScreenEmployeeList.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        builder: (context, child) {
          /// here we have called the bloc instance and assign the local database instance
          return BlocProvider<SqFlitDatabaseCubit>(
              create: (BuildContext context) => SqFlitDatabaseCubit(UserRepo()),
              child: MaterialApp(
                  theme: ThemeData(primaryColor: const Color(0xff1DA1F2)),
                  home: ScreenEmployeeList()));
        });
  }
}

// https://www.figma.com/file/JYuw7GtpDzTrUDVjUGAT08/Flutter-Assignment-2?type=design&node-id=1-1892&t=qD6KdvKwFDJ7HYTb-0
