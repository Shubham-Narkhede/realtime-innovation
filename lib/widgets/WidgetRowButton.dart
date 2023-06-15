import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtime_innovation/helper/HelperNavigation.dart';

import '../helper/HelperColor.dart';
import 'WidgetButton.dart';
import 'WidgetText.dart';

/// this widget is bottom of two buttons
/// it contains two button which we are showing the bottom and right side
class WidgetRowButton extends StatelessWidget {
  VoidCallback onTapSave;

  WidgetRowButton({required this.onTapSave});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: HelperColor.instance.colorBackground))),
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.only(
        top: 12.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              margin: EdgeInsets.only(right: 16.w),
              child: WidgetButton(
                  title: "Cancel",
                  color: HelperColor.instance.colorPrimary.withOpacity(0.1),
                  textStyle: textStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      textColor: HelperColor.instance.colorPrimary),
                  enumButtonType: GEnumButtonType.bgOutLinedButton,
                  borderRadius: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  onPressed: () {
                    HelperNavigation.instance.navigatePop(context);
                  })),
          WidgetButton(
              title: "Save",
              borderRadius: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              onPressed: () {
                onTapSave();
              }),
        ],
      ),
    );
  }
}
