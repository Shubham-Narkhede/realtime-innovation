import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtime_innovation/helper/HelperExtension.dart';

import '../../helper/HelperColor.dart';
import '../../models/ModelCalendarDayData.dart';
import '../WidgetText.dart';

class WidgetWeekDays extends StatelessWidget {
  WidgetWeekDays({
    required this.selectedMonth,
    required this.selectedDate,
    required this.selectDate,
  });

  final DateTime selectedMonth;
  final DateTime? selectedDate;

  final ValueChanged<DateTime> selectDate;

  List<String> weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thr', 'Fri', 'Sat'];

  @override
  Widget build(BuildContext context) {
    var data = CalendarMonthData(
      year: selectedMonth.year,
      month: selectedMonth.month,
    );

    return Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: weekDays
                .map<Widget>((e) => widgetText(
                    text: e,
                    textStyle:
                        textStyle(fontSize: 15, fontWeight: FontWeight.w400)))
                .toList()),
        SizedBox(height: 10.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var week in data.weeks)
              Row(
                children: week.map((d) {
                  return Expanded(
                    child: WidgetDateDays(
                      hasRightBorder: false,
                      date: d.date,
                      isActiveMonth: d.isActiveMonth,
                      onTap: () => selectDate(d.date),
                      isSelected: selectedDate != null &&
                          selectedDate!.isSameDate(d.date),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ],
    );
  }
}

class WidgetDateDays extends StatelessWidget {
  const WidgetDateDays({
    required this.hasRightBorder,
    required this.isActiveMonth,
    required this.isSelected,
    required this.date,
    required this.onTap,
  });

  final bool hasRightBorder;
  final bool isActiveMonth;
  final VoidCallback onTap;
  final bool isSelected;

  final DateTime date;
  @override
  Widget build(BuildContext context) {
    final int number = date.day;
    final isToday = date.isToday;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.only(left: 5, top: 5),
        alignment: Alignment.center,
        height: 35,
        decoration: isSelected
            ? BoxDecoration(
                color: HelperColor.instance.colorPrimary,
                shape: BoxShape.circle)
            : isToday
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: HelperColor.instance.colorPrimary,
                    ),
                  )
                : null,
        child: widgetText(
          text: number.toString(),
          textStyle: textStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              textColor: isSelected
                  ? Colors.white
                  : isToday
                      ? HelperColor.instance.colorPrimary
                      : isActiveMonth
                          ? Colors.black
                          : Colors.grey[300]),
        ),
      ),
    );
  }
}
