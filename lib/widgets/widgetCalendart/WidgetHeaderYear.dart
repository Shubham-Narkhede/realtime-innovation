import 'package:flutter/material.dart';
import 'package:realtime_innovation/helper/HelperExtension.dart';

import '../WidgetText.dart';

class WidgetHeaderYear extends StatelessWidget {
  WidgetHeaderYear({
    required this.selectedMonth,
    required this.selectedDate,
    required this.onChange,
  });

  final DateTime selectedMonth;
  final DateTime? selectedDate;

  final ValueChanged<DateTime> onChange;

  List months = [
    'Jan',
    'Feb',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  onChange(selectedMonth.addMonth(-1));
                },
                icon: const Icon(
                  Icons.arrow_left_sharp,
                  size: 30,
                ),
              ),
              widgetText(
                  text:
                      "${months[selectedMonth.month - 1]} ${selectedYear == null ? DateTime.now().year : selectedYear!}",
                  textStyle:
                      textStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              IconButton(
                onPressed: () {
                  onChange(selectedMonth.addMonth(1));
                },
                icon: const Icon(
                  Icons.arrow_right_sharp,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
