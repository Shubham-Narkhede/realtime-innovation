import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtime_innovation/helper/HelperColor.dart';
import 'package:realtime_innovation/screens/ScreenUserList.dart';
import 'package:realtime_innovation/widgets/WidgetText.dart';

import '../cubit/CubitSqFliteDatabse.dart';
import '../helper/HelperNavigation.dart';
import '../widgets/WidgetAppBar.dart';
import 'ScreenAddUpdateEmployee.dart';

// ScreenEmployeeList this screen is created to show the all employee list

class ScreenEmployeeList extends StatefulWidget {
  @override
  _ScreenEmployeeListState createState() => _ScreenEmployeeListState();
}

class _ScreenEmployeeListState extends State<ScreenEmployeeList> {
  @override
  void initState() {
    super.initState();

    /// here we have initialize the database
    BlocProvider.of<SqFlitDatabaseCubit>(context).init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HelperColor.instance.colorBackground,
      appBar: WidgetAppBar(
        title: "Employee List",
      ),
      body: BlocConsumer<SqFlitDatabaseCubit, SqFliteDatabaseState>(
          listener: (_, state) {
        /// if we delete any user then we are showing the snakbar at the below of screen
        /// so we have added below function
        if (state is StateDeleted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widgetText(
                  text: "Employee Data has been deleted",
                  textStyle: textStyle(fontSize: 15.h)),
              widgetText(
                  text: "UNDO",
                  textStyle:
                      textStyle(textColor: HelperColor.instance.colorPrimary))
            ],
          )));
        }
      }, builder: (_, state) {
        /// if state is loading then we show loader
        if (state is StateLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else

        /// if state is success then we show the data on the basis of response
        /// if data is empty then we are showing no user data available
        /// else we show the listview of user info
        if (state is StateSuccess) {
          return state.listUser.isEmpty
              ? Center(
                  child: Image.asset("assets/noUser.png"),
                )
              : ScreenUserList(
                  listUser: state.listUser,
                );
        } else

        /// if we get any error then we are showing the error directly on the ui
        if (state is StateError) {
          return widgetText(text: state.error.toString());
        }
        return Container();
      }),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        child: const Icon(Icons.add),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () {
          HelperNavigation.instance.navigatePush(context, ScreenAddUpdateEmployee());
        },
      ),
    );
  }
}
