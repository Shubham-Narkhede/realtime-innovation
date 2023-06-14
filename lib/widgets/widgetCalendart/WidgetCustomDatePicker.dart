import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtime_innovation/helper/HelperColor.dart';
import 'package:realtime_innovation/helper/HelperExtension.dart';
import 'package:realtime_innovation/helper/HelperNavigation.dart';
import 'package:realtime_innovation/widgets/WidgetAssetImage.dart';
import 'package:realtime_innovation/widgets/WidgetButton.dart';
import 'package:realtime_innovation/widgets/WidgetText.dart';

import '../../helper/HelperFunction.dart';
import '../WidgetRowButton.dart';
import 'WidgetHeaderYear.dart';
import 'WidgetWeekDays.dart';

class WidgetCustomCalendar extends StatefulWidget {
  WidgetCustomCalendar(
      {super.key, required this.selectedDate, this.isToDate = false});

  Function(DateTime) selectedDate;
  bool isToDate;

  @override
  State<WidgetCustomCalendar> createState() => WidgetCustomCalendarState();
}

class WidgetCustomCalendarState extends State<WidgetCustomCalendar> {
  late DateTime selectedMonth;

  DateTime? selectedDate;
  bool isNoDateSelected = false;

  @override
  void initState() {
    selectedMonth = DateTime.now().monthStart;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.isToDate)
            Container(
              margin: EdgeInsets.only(top: 16.h, bottom: 16.h),
              child: Row(
                children: [
                  widgetChild(
                      right: 8,
                      enumButtonType: isNoDateSelected == false
                          ? GEnumButtonType.bgOutLinedButton
                          : GEnumButtonType.filledButton,
                      onTap: () {
                        setState(() {
                          isNoDateSelected = true;
                          selectedDate = null;
                        });
                      },
                      title: 'No Date'),
                  widgetButton(1, "Today", DateTime.now().day,
                      dateTime: DateTime.now(), left: 8.w),
                ],
              ),
            ),
          if (!widget.isToDate)
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 16.h, bottom: 16.h),
                  child: Row(
                    children: [
                      widgetButton(1, "Today", DateTime.now().day,
                          dateTime: DateTime.now(), right: 8.w),
                      widgetButton(
                          DateTime.monday,
                          "Next Monday",
                          (selectedDate == null
                                  ? DateTime.now()
                                  : selectedDate!)
                              .next(DateTime.monday)
                              .day,
                          left: 8.w)
                    ],
                  ),
                ),
                Row(
                  children: [
                    widgetButton(
                      DateTime.tuesday,
                      "Next Tuesday",
                      (selectedDate == null ? DateTime.now() : selectedDate!)
                          .next(DateTime.tuesday)
                          .day,
                      right: 8.w,
                    ),
                    widgetButton(1, "After 1 Week",
                        DateTime.now().add(const Duration(days: 7)).day,
                        dateTime: DateTime.now().add(const Duration(days: 7)),
                        left: 8.w),
                  ],
                ),
              ],
            ),
          WidgetHeaderYear(
            selectedMonth: selectedMonth,
            selectedDate: selectedDate,
            onChange: (value) => setState(() => selectedMonth = value),
          ),
          WidgetWeekDays(
            selectedDate: selectedDate,
            selectedMonth: selectedMonth,
            selectDate: (DateTime value) => setState(() {
              selectedDate = value;
            }),
          ),
          Container(
              padding: EdgeInsets.only(right: 16.w, left: 16.w),
              child: Row(
                children: [
                  RichText(
                      text: TextSpan(children: [
                    WidgetSpan(
                        child: Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: WidgetAssetImage(
                        imagePath: "date",
                      ),
                    )),
                    TextSpan(
                        text: selectedDate == null
                            ? "No Date"
                            : HelperFunction.dateFormat(
                                "d MMM yyyy", selectedDate!),
                        style: textStyle(
                            textColor: HelperColor.instance.colorGrey_8,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400))
                  ])),
                  Expanded(child: WidgetRowButton(
                    onTapSave: () {
                      if (selectedDate != null) {
                        widget.selectedDate(selectedDate!);
                      } else {
                        if (widget.isToDate == true) {
                          HelperNavigation.instance.navigatePop(context);
                        } else {
                          HelperFunction.showFlushbarError(
                              context, "Please select date first");
                        }
                      }
                    },
                  )),
                ],
              )),
        ],
      ),
    );
  }

  Widget widgetButton(
    int day,
    String title,
    int date, {
    DateTime? dateTime,
    double left = 16,
    double right = 16,
  }) {
    return widgetChild(
      left: left,
      right: right,
      onTap: () {
        setState(() {
          isNoDateSelected = false;
          selectedDate =
              dateTime ?? (selectedDate ??= DateTime.now()).next(day);
        });
      },
      title: title,
      enumButtonType: selectedDate == null
          ? GEnumButtonType.bgOutLinedButton
          : selectedDate!.day == date
              ? GEnumButtonType.filledButton
              : GEnumButtonType.bgOutLinedButton,
    );
  }

  Widget widgetChild(
      {double left = 16,
      double right = 16,
      required Function onTap,
      required String title,
      required GEnumButtonType enumButtonType}) {
    return Expanded(
        child: Container(
            margin: EdgeInsets.only(left: left, right: right),
            child: WidgetButton(
                onPressed: () {
                  onTap();
                },
                title: title,
                color: HelperColor.instance.colorPrimary,
                enumButtonType: enumButtonType)));
  }
}
