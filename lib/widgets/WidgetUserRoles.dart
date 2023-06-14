import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtime_innovation/helper/HelperColor.dart';
import 'package:realtime_innovation/widgets/WidgetText.dart';

import '../helper/HelperNavigation.dart';

class ModalBottomSheet {
  static void moreModalBottomSheet(context, Function(String) callback) {
    Size size = MediaQuery.of(context).size;

    List<String> list = [
      "Product Designer",
      "QA Tester",
      "Flutter Developer",
      "Product Owner"
    ];

    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            height: size.height * 0.3,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
              ),
            ),
            child: ListView(
              physics: const ClampingScrollPhysics(),
              children: list.map<Widget>((e) {
                return InkWell(
                  onTap: () {
                    callback(e);
                    HelperNavigation.instance.navigatePop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: HelperColor.instance.colorBorderColor))),
                    padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
                    child: Center(
                      child: widgetText(
                          text: e,
                          textStyle: textStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              textColor: HelperColor.instance.colorGrey_8)),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        });
  }
}
