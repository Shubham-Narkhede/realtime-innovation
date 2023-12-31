import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtime_innovation/helper/HelperColor.dart';
import 'package:realtime_innovation/helper/HelperNavigation.dart';
import 'package:realtime_innovation/widgets/WidgetAssetImage.dart';

import '../cubit/CubitSqFliteDatabse.dart';
import '../models/ModelUser.dart';
import '../widgets/WidgetSlideChild.dart';
import '../widgets/WidgetText.dart';
import 'ScreenAddUpdateEmployee.dart';

// ScreenUserList this screen we are using for showing the listview of users
// basically in this screen we are showing two different type of user
// 1) Current Employee
// 2) Previous employee
class ScreenUserList extends StatefulWidget {
  List<ModelUser> listUser;
  ScreenUserList({required this.listUser});
  @override
  _ScreenUserListState createState() => _ScreenUserListState();
}

class _ScreenUserListState extends State<ScreenUserList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          /// is user don't added there to date it means this employee is currentemp
          if (widget.listUser
              .where((element) => element.toDate.isEmpty)
              .toList()
              .isNotEmpty)
            Column(
              children: [
                widgetHeader("Current"),
                ...widget.listUser
                    .where((element) => element.toDate.isEmpty)
                    .map((ModelUser user) => widgetListItem(user))
                    .toList(),
              ],
            ),

          /// is user added there to date it means this employee is previous emp
          if (widget.listUser
              .where((element) => element.toDate.isNotEmpty)
              .toList()
              .isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widgetHeader("Previous"),
                ...widget.listUser
                    .where((element) => element.toDate.isNotEmpty)
                    .map((ModelUser user) => widgetListItem(user))
                    .toList(),
              ],
            )
        ],
      ),
    );
  }

// this widget is created to show the title of list
  Widget widgetHeader(String title) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: HelperColor.instance.colorBackground,
      padding: EdgeInsets.all(16.w),
      child: widgetText(
          text: "$title employees",
          textStyle: textStyle(
              textColor: HelperColor.instance.colorPrimary,
              fontWeight: FontWeight.w500,
              fontSize: 16.sp)),
    );
  }

  // this is the list of item
  Widget widgetListItem(ModelUser user) {
    return InkWell(
      onTap: () {
        // here we are navigating to the next page for update the user info
        HelperNavigation.instance.navigatePush(
            context,
            ScreenAddUpdateEmployee(
              user: user,
            ));
      },
      child: WidgetSlideChild(
        menuItems: [
          IconButton(
              onPressed: () {
                // this method is created to delete the emp
                deleteUser(user.id!);
              },
              icon: WidgetAssetImage(imagePath: "delete"))
        ],
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1,
                        color: HelperColor.instance.colorBorderColor))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widgetText(
                    text: user.userName.capitalize(),
                    textStyle: textStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.w500)),
                Container(
                  margin: EdgeInsets.only(top: 6.h, bottom: 6.h),
                  child: widgetText(
                      text: user.userRole,
                      textStyle: textStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          textColor: HelperColor.instance.colorGrey_7)),
                ),
                if (user.toDate.isEmpty)
                  widgetText(
                      text: "From ${user.fromDate}",
                      textStyle: textStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          textColor: HelperColor.instance.colorGrey_7)),
                if (user.toDate.isNotEmpty)
                  widgetText(
                      text: "${user.fromDate} - ${user.toDate}",
                      textStyle: textStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          textColor: HelperColor.instance.colorGrey_7)),
              ],
            )),
      ),
    );
  }

  deleteUser(int id) {
    SqFlitDatabaseCubit cubit = SqFlitDatabaseCubit.get(context);
    cubit.deleteUser(id);
  }
}
