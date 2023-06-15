import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'WidgetText.dart';

/// this is common appbar we have created
class WidgetAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  bool showSpIcon;
  double appBarHeight;
  List<Widget>? listAction;

  WidgetAppBar(
      {required this.title,
      this.showSpIcon = true,
      this.appBarHeight = 60,
      this.listAction});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: widgetText(
        text: title,
        textStyle: textStyle(
            textColor: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 18.sp),
      ),
      actions: listAction ?? [],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
