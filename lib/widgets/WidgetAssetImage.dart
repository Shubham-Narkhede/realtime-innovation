import 'package:flutter/material.dart';

class WidgetAssetImage extends StatelessWidget {
  double? width;
  double? height;
  String imagePath;
  WidgetAssetImage({this.height, required this.imagePath, this.width});
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/$imagePath.png",
      width: width,
      height: height,
    );
  }
}
