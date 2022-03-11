import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/route/widget/banner/config.dart';
import 'package:wanandroid_flutter/route/widget/banner/indicator_util.dart';

class IndicatorWidget extends StatelessWidget {
  final IndicatorContainerBuilder? indicatorBuilder;
  final Widget? indicatorNormal;
  final Widget? indicatorSelected;
  final double indicatorMargin;
  final int size;
  final int currentIndex;

  IndicatorWidget({
    Key? key,
    required this.size,
    required this.currentIndex,
    this.indicatorBuilder,
    this.indicatorNormal,
    this.indicatorSelected,
    this.indicatorMargin = 5.0,
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return _renderIndicator(context);
  }

  Widget _renderIndicator(BuildContext context) {
    Widget smallContainer = Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _renderIndicatorTag(),
      ),
    );

    if (indicatorBuilder != null) {
      return indicatorBuilder!(context,smallContainer);
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: Opacity(
        opacity: 0.5,
        child: Container(
          height: 40.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          color: Colors.black45,
          alignment: Alignment.centerRight,
          child: smallContainer,
        ),
      ),
    );
  }

  List<Widget> _renderIndicatorTag() {
    List<Widget> indicators = [];
    final int len = size;
    Widget selected =
        indicatorSelected ?? IndicatorUtil.generateIndicatorItem(normal: false);
    Widget normal =
        indicatorNormal ?? IndicatorUtil.generateIndicatorItem(normal: true);

    for (var index = 0; index < len; index++) {
      indicators.add(index == currentIndex ? selected : normal);
    }
    return indicators;
  }
}
