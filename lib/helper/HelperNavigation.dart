import 'package:flutter/material.dart';

class HelperNavigation {
  HelperNavigation._();

  static final instance = HelperNavigation._();

  navigatePush(BuildContext context, Widget child) {
    return Navigator.push(context, MaterialPageRoute(builder: (_) => child));
  }

  navigatePop(BuildContext context) {
    return Navigator.pop(context);
  }
}
