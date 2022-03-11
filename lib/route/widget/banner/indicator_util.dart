import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndicatorUtil {
  static Widget generateIndicatorItem(
      {bool normal = true, double indicatorSize = 8.0}) {
    return Container(
      width: indicatorSize,
      height: indicatorSize,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: normal ? Colors.white : Colors.red
      ),
    );
  }
}
