import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanandroid_flutter/res/colors.dart';
import 'package:wanandroid_flutter/route/api/wan_repository.dart';

import '../model/model.dart';
import '../widget/favorite_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  bool refreshBanner = true;
  List<String> banners = [];
  List<ArticleModel> articles = [];
  int itemCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("首 页"),
        ),
        body: Container(
          color: WColors.color_fff3f6f9,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [_bannerView(), _articleList()]),
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bannerList();
    _getArticleList();
  }

  void _bannerList() {
    WanRepository().getBanner().then((value) {
      print("-----$value");
      List<String> bannerlist = [];
      value?.forEach((element) {
        bannerlist.add(element.imagePath);
      });

      if (refreshBanner) {
        refreshBanner = false;
        setState(() {
          banners = [];
          banners.addAll(bannerlist);
          print('测试${banners.toString()}');
        });
      }
    });
  }

  void _getArticleList() {
    WanRepository().getArticleList(page: 0).then((value) {
      print('-----$value');
      if (value != null) {
        setState(() {
          articles.addAll(value);
          print('-----${articles[0].fresh}');
        });
      }
    });
  }

  Widget _bannerView() {
    return Container(
        alignment: Alignment.topCenter,
        height: ScreenUtil().setHeight(172),
        child: Swiper(
          autoplay: banners.isNotEmpty,
          loop: banners.isNotEmpty,
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
          controller: SwiperController(),
        ));
  }

  Widget _articleList() {
    return Expanded(
        child: Container(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            color: Colors.white,
            child: ListView.builder(
                itemCount: articles.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Visibility(
                              child: Padding(
                                  padding: EdgeInsets.only(right: 8.w),
                                  child: Container(
                                    width: 20.w,
                                    height: 20.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.w)),
                                        border: Border.all(
                                            width: 1,
                                            color: WColors.color_ffEB4534)),
                                    child: Text(
                                      "新",
                                      style: TextStyle(
                                        color: WColors.color_ffEB4534,
                                        fontSize: 12.w,
                                      ),
                                    ),
                                  )),
                              visible: articles[index].fresh == true,
                            ),
                            Text(
                              "${articles[index].shareUser?.isNotEmpty == true ? articles[index].shareUser : articles[index].author}",
                              style: const TextStyle(color: Colors.black54),
                            ),
                            const Expanded(child: Text("")),
                            Text(
                              "${articles[index].niceShareDate}",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12.w),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.w, bottom: 12.w),
                        child: Text(
                          "${articles[index].title}",
                          style: TextStyle(fontSize: 16.w, color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.w, bottom: 8.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                "${articles[index].superChapterName}/${articles[index].chapterName}",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12.w),
                              ),
                            ),
                            Expanded(child: Text('')),
                            FavoriteWidget(onChanged: (v){
                              print("FavoriteWidget:$v");
                            },),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        color: WColors.color_fff3f6f9,
                      )
                    ],
                  );
                })));
  }

  Widget _favoriteSelect(int index) {
    if (articles[index].collect == true) {
      return const Icon(Icons.favorite);
    } else {
      return const Icon(Icons.favorite_rounded);
    }
  }
}
