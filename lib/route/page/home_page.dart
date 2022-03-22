import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/route/api/wan_repository.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  bool refreshBanner = true;
  List<String> banners = [];
  int itemCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("首 页"),
        ),
        body: Container(
          color: WColors.color_fff3f6f9,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
                alignment: Alignment.topCenter,
                height: ScreenUtil().setHeight(172),
                child: Swiper(
                  autoplay: true,
                  itemCount: banners.length,
                  itemBuilder: (context, index) {
                    print('index:$index ${banners[index]}');
                    return Container(
                      clipBehavior: Clip.hardEdge,
                      margin: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16.w)),
                          color: Colors.white),
                      child: Image.network(banners[index]),
                    );
                  },
                  viewportFraction: 0.8,
                  pagination: SwiperPagination(),
                )),
          ]),
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bannerList();
  }

  void _bannerList() {
    WanRepository().getBanner().then((value) {
      print("-----$value");
      List<String> bannerlist = [];
      value?.forEach((element) {
        bannerlist.add(element.imagePath);
      });

      if (refreshBanner) {
        setState(() {
          banners = [];
          banners.addAll(bannerlist);
          print('测试${banners.toString()}');
        });
      }
    });
  }
}
