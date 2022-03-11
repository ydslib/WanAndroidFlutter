import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'banner/config.dart';
import 'banner/indicator_widget.dart';

class Banner extends StatefulWidget {
  final List<Widget> banners;
  final int defaultIndex;

  //switch interval
  final Duration intervalDuration;

  //animation duration
  final Duration animationDuration;
  final IndicatorContainerBuilder? indicatorBuilder;
  final Widget? indicatorNormal;
  final Widget? indicatorSelected;

  //the margin of between indicator items
  final double indicatorMargin;
  final PageController? controller;

  //whether cycle rolling
  final bool cycleRolling;

  //whether auto rolling
  final bool autoRolling;
  final Curve? curve;
  final ValueChanged? onPageChanged;
  final bool log;

  Banner(this.banners,
      {Key? key,
      this.defaultIndex = 0,
      this.intervalDuration = const Duration(seconds: 1),
      this.animationDuration = const Duration(milliseconds: 500),
      this.indicatorBuilder,
      this.indicatorNormal,
      this.indicatorSelected,
      this.indicatorMargin = 5.0,
      this.controller,
      this.cycleRolling = true,
      this.autoRolling = true,
      this.curve,
      this.onPageChanged,
      this.log = true})
      : super(key: key);

  @override
  _BannerState createState() => _BannerState();
}

class _BannerState extends State<Banner> {
  List<Widget> _originBanners = [];
  List<Widget> _banners = [];
  Duration? _duration;
  PageController? _pageController;
  int _currentIndex = 0;
  bool _isActive = true;
  Timer? _timer;

  bool _isEndByUser = false;
  bool _isStartByUser = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isActive = true;
    _originBanners = widget.banners;
    _banners = _banners..addAll(_originBanners);

    if (widget.cycleRolling) {
      Widget first = _originBanners[0];
      Widget last = _originBanners[_originBanners.length - 1];
      _banners.insert(0, last);
      _banners.add(first);
      _currentIndex = widget.defaultIndex + 1;
    } else {
      _currentIndex = widget.defaultIndex;
    }
    _duration = widget.intervalDuration;
    _pageController =
        widget.controller ?? PageController(initialPage: _currentIndex);
  }

  void _nextBannerTask() {
    _nextBannerTaskBy(milliseconds: 0);
  }

  void _nextBannerTaskBy({int milliseconds = 0}) {
    if (!mounted) {
      return;
    }

    if (!widget.autoRolling) {
      return;
    }
    _cancel();

    _timer = Timer(
        Duration(milliseconds: (_duration?.inMilliseconds ?? 0) + milliseconds),
        () {
      _doChangeIndex();
    });
  }

  void _cancel() {
    _timer?.cancel();
  }

  void _doChangeIndex({bool increment = true}) {
    if (!mounted) {
      return;
    }
    if (increment) {
      _currentIndex++;
    } else {
      _currentIndex--;
    }

    _currentIndex = _currentIndex % _banners.length;

    if (_currentIndex == 0) {
      _pageController?.jumpToPage(_currentIndex + 1);
      _nextBannerTaskBy(milliseconds: -(_duration?.inMilliseconds ?? 0));
      setState(() {});
    } else {
      _pageController?.animateToPage(_currentIndex,
          duration: widget.animationDuration, curve: widget.curve!);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _generateBody();
  }

  Widget _generateBody() {
    return Stack(
      children: <Widget>[
        _renderBannerBody(),
        _renderIndicator(),
      ],
    );
  }

  /// Banner container
  Widget _renderBannerBody() {
    Widget pageView = PageView.builder(
      itemBuilder: (context, index) {
        Widget widget = _banners[index];
        return GestureDetector(
          child: widget,
        );
      },
      controller: _pageController,
      itemCount: _banners.length,
      onPageChanged: (index) {
        _currentIndex = index;
        _nextBannerTask();
        setState(() {});
        if (null != widget.onPageChanged) {
          widget.onPageChanged!(index);
        }
      },
      physics: const ClampingScrollPhysics(),
    );

    // return pageView;
    return NotificationListener(
      child: pageView,
      onNotification: (notification) {
        _handleScrollNotification(notification as Notification);
        return true;
      },
    );
  }

  void _handleScrollNotification(Notification notification) {
    void _resetWhenAtEdge(PageMetrics pm) {
      if (!pm.atEdge) {
        return;
      }
      if (!widget.cycleRolling) {
        return;
      }
      try {
        if (_currentIndex == 0) {
          _pageController?.jumpToPage(_banners.length - 2);
        } else if (_currentIndex == _banners.length - 1) {
          _pageController?.jumpToPage(1);
        }
        setState(() {});
      } catch (e) {
        // _Logger.d(TAG, 'Exception: ${e?.toString()}');
      }
    }

    void _handleUserScroll(UserScrollNotification notification) {
      UserScrollNotification sn = notification;

      PageMetrics pm = sn.metrics as PageMetrics;
      var page = pm.page;
      var depth = sn.depth;

      var left = page == .0 ? .0 : page ?? 0 % (page?.round() ?? 1);

      if (depth == 0) {
        // _Logger.d(TAG,
        //     '**  page: $page  , left: $left ,  atEdge: ${pm.atEdge} ,  index: $_currentIndex');

        if (left == 0) {
          setState(() {
            _resetWhenAtEdge(pm);
          });
        }
      }
    }

    if (notification is UserScrollNotification) {
      if (_isStartByUser) {
        return;
      }
      if (_isEndByUser) {
        _isEndByUser = false;
      } else {
        // _Logger.d(TAG, '#########   手动开始');
        _isStartByUser = true;
        _cancel();
      }

      _handleUserScroll(notification);
    } else if (notification is ScrollEndNotification) {
      // _Logger.d(
      //     TAG, '#########   ${notification.runtimeType}    $_isStartByUser');

      if (_isEndByUser) {
        return;
      }
      if (_isStartByUser) {
        // _Logger.d(TAG, '#########   手动结束');
        _isEndByUser = true;
        _isStartByUser = false;
      } else {
        _isEndByUser = false;
      }

      this._nextBannerTask();
    }
  }

  /// indicator widget
  Widget _renderIndicator() {
    int index =
        widget.cycleRolling ? this._currentIndex - 1 : this._currentIndex;
    index = index <= 0 ? 0 : index;
    index = index % _originBanners.length;
    return IndicatorWidget(
      size: _originBanners.length,
      currentIndex: index,
      indicatorBuilder: widget.indicatorBuilder,
      indicatorNormal: widget.indicatorNormal,
      indicatorSelected: widget.indicatorSelected,
      indicatorMargin: widget.indicatorMargin,
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    _isActive = !_isActive;
    if (_isActive) {
      _nextBannerTask();
    } else {
      _cancel();
    }
  }

  @override
  void dispose() {
    _isActive = false;
    _pageController?.dispose();
    _cancel();
    super.dispose();
  }
}
