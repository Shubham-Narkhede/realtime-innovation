import 'package:flutter/material.dart';

class HelperNavigation {
  HelperNavigation._();

  static final instance = HelperNavigation._();

  /// navigatePush this method is created to navigate on next page
  navigatePush(BuildContext context, Widget child) {
    return Navigator.push(context, MaterialPageRoute(builder: (_) => child));
  }

  /// navigatePush this method is created to navigate on back page
  navigatePop(BuildContext context) {
    return Navigator.pop(context);
  }
}
